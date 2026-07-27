#requires -Version 5.1
<#+
.SYNOPSIS
    Collects Windows Update readiness information for Intune-managed devices.
.DESCRIPTION
    Produces a readable console summary and optional JSON output containing OS,
    storage, service, reboot, BitLocker and MDM enrolment indicators.
.PARAMETER OutputPath
    Optional path for a JSON report.
.EXAMPLE
    .\Get-WindowsUpdateReadiness.ps1 -OutputPath C:\Temp\WU-Readiness.json
.NOTES
    Author: Xuan Toan Nguyen | #ToanNguyenITOz
#>
[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Test-PendingReboot {
    $paths = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending',
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'
    )

    foreach ($path in $paths) {
        if (Test-Path $path) { return $true }
    }

    $sessionManager = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'
    try {
        $pending = (Get-ItemProperty -Path $sessionManager -Name PendingFileRenameOperations -ErrorAction Stop).PendingFileRenameOperations
        return [bool]$pending
    }
    catch {
        return $false
    }
}

try {
    $os = Get-CimInstance Win32_OperatingSystem
    $computer = Get-CimInstance Win32_ComputerSystem
    $bios = Get-CimInstance Win32_BIOS
    $systemDrive = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$($os.SystemDrive)'"
    $services = Get-Service wuauserv, bits, usosvc, cryptsvc -ErrorAction SilentlyContinue |
        Select-Object Name, Status, StartType

    $bitLocker = if (Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue) {
        Get-BitLockerVolume -MountPoint $os.SystemDrive -ErrorAction SilentlyContinue |
            Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionMethod
    }

    $report = [ordered]@{
        CollectedAt       = (Get-Date).ToString('o')
        ComputerName      = $env:COMPUTERNAME
        Manufacturer      = $computer.Manufacturer
        Model             = $computer.Model
        SerialNumber      = $bios.SerialNumber
        WindowsCaption    = $os.Caption
        WindowsVersion    = $os.Version
        BuildNumber       = $os.BuildNumber
        LastBootTime      = $os.LastBootUpTime
        SystemDrive       = $os.SystemDrive
        FreeSpaceGB       = [math]::Round($systemDrive.FreeSpace / 1GB, 2)
        TotalSpaceGB      = [math]::Round($systemDrive.Size / 1GB, 2)
        PendingReboot     = Test-PendingReboot
        Services          = $services
        BitLocker         = $bitLocker
        MdmEnrollmentKeys = @(Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Enrollments' -ErrorAction SilentlyContinue).Count
    }

    [pscustomobject]$report | Format-List

    if ($OutputPath) {
        $directory = Split-Path -Parent $OutputPath
        if ($directory -and -not (Test-Path $directory)) {
            New-Item -ItemType Directory -Path $directory -Force | Out-Null
        }
        [pscustomobject]$report | ConvertTo-Json -Depth 6 | Set-Content -Path $OutputPath -Encoding UTF8
        Write-Host "Report saved to $OutputPath"
    }
}
catch {
    Write-Error "Readiness collection failed: $($_.Exception.Message)"
    exit 1
}
