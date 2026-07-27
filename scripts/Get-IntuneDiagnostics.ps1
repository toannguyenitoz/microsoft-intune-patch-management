#requires -Version 5.1
<#+
.SYNOPSIS
    Collects a lightweight Intune and Windows Update diagnostic bundle.
.DESCRIPTION
    Exports service state, system information, update history, selected event logs,
    MDM diagnostics and Windows Update logs into a timestamped folder, then creates ZIP.
.PARAMETER OutputDirectory
    Parent directory for the diagnostic bundle.
.NOTES
    Run as administrator. Review output for sensitive information before sharing.
    Author: Xuan Toan Nguyen | #ToanNguyenITOz
#>
[CmdletBinding()]
param(
    [ValidateNotNullOrEmpty()]
    [string]$OutputDirectory = 'C:\Windows\Temp'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Continue'

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$bundle = Join-Path $OutputDirectory "IntuneDiagnostics-$env:COMPUTERNAME-$timestamp"
$zipPath = "$bundle.zip"
New-Item -Path $bundle -ItemType Directory -Force | Out-Null

Write-Host "Collecting diagnostics in $bundle"

Get-ComputerInfo | Out-File (Join-Path $bundle 'ComputerInfo.txt') -Encoding utf8
Get-Service wuauserv, bits, usosvc, cryptsvc, dmwappushservice -ErrorAction SilentlyContinue |
    Format-List * | Out-File (Join-Path $bundle 'Services.txt') -Encoding utf8

Get-CimInstance Win32_QuickFixEngineering |
    Sort-Object InstalledOn -Descending |
    Export-Csv (Join-Path $bundle 'QuickFixEngineering.csv') -NoTypeInformation -Encoding utf8

$logs = @(
    'Microsoft-Windows-WindowsUpdateClient/Operational',
    'Microsoft-Windows-UpdateOrchestrator/Operational',
    'Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin'
)

foreach ($log in $logs) {
    $safeName = ($log -replace '[\\/:*?"<>|]', '_') + '.evtx'
    & wevtutil.exe epl $log (Join-Path $bundle $safeName) /ow:true 2>$null
}

try {
    & mdmdiagnosticstool.exe -area 'DeviceEnrollment;DeviceProvisioning;Autopilot' -cab (Join-Path $bundle 'MDMDiagnostics.cab') | Out-Null
}
catch {
    "MDM diagnostics failed: $($_.Exception.Message)" | Out-File (Join-Path $bundle 'CollectionErrors.txt') -Append
}

try {
    Get-WindowsUpdateLog -LogPath (Join-Path $bundle 'WindowsUpdate.log') | Out-Null
}
catch {
    "Windows Update log generation failed: $($_.Exception.Message)" | Out-File (Join-Path $bundle 'CollectionErrors.txt') -Append
}

@"
Diagnostic bundle created: $(Get-Date -Format o)
Computer: $env:COMPUTERNAME

WARNING: This bundle can contain device, tenant and user-identifying information.
Review all files before sending them outside your organisation.
"@ | Set-Content (Join-Path $bundle 'README.txt') -Encoding utf8

if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Compress-Archive -Path (Join-Path $bundle '*') -DestinationPath $zipPath -Force
Write-Host "Diagnostic bundle created: $zipPath"
