#requires -Version 5.1
<#+
.SYNOPSIS
    Tests basic HTTPS connectivity to Microsoft service endpoints used during troubleshooting.
.DESCRIPTION
    This is a lightweight DNS/TCP/HTTPS test, not a complete validation of every required URL.
.PARAMETER OutputPath
    Optional CSV export path.
.NOTES
    Proxy, TLS inspection and tenant-specific requirements can affect results.
    Validate the current official Microsoft endpoint list for production firewall rules.
    Author: Xuan Toan Nguyen | #ToanNguyenITOz
#>
[CmdletBinding()]
param(
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Continue'

$targets = @(
    'login.microsoftonline.com',
    'enrollment.manage.microsoft.com',
    'portal.manage.microsoft.com',
    'windowsupdate.microsoft.com',
    'update.microsoft.com',
    'delivery.mp.microsoft.com'
)

$results = foreach ($target in $targets) {
    $dnsResolved = $false
    $tcpSucceeded = $false
    $httpsStatus = $null
    $errorMessage = $null

    try {
        [void][System.Net.Dns]::GetHostAddresses($target)
        $dnsResolved = $true
    }
    catch {
        $errorMessage = $_.Exception.Message
    }

    try {
        $tcpSucceeded = Test-NetConnection -ComputerName $target -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue
    }
    catch {
        if (-not $errorMessage) { $errorMessage = $_.Exception.Message }
    }

    try {
        $response = Invoke-WebRequest -Uri "https://$target" -Method Head -UseBasicParsing -TimeoutSec 15
        $httpsStatus = [int]$response.StatusCode
    }
    catch {
        if ($_.Exception.Response) {
            $httpsStatus = [int]$_.Exception.Response.StatusCode
        }
        elseif (-not $errorMessage) {
            $errorMessage = $_.Exception.Message
        }
    }

    [pscustomobject]@{
        Endpoint     = $target
        DNSResolved  = $dnsResolved
        TCP443       = $tcpSucceeded
        HTTPSStatus  = $httpsStatus
        Error        = $errorMessage
    }
}

$results | Format-Table -AutoSize

if ($OutputPath) {
    $directory = Split-Path -Parent $OutputPath
    if ($directory -and -not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "Connectivity results exported to $OutputPath"
}
