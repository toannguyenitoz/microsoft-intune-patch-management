#requires -Version 5.1
<#+
.SYNOPSIS
    Exports recent Windows Update history from the Windows Update Agent API.
.PARAMETER Days
    Number of days of history to include. Default: 60.
.PARAMETER OutputPath
    Optional CSV export path.
.EXAMPLE
    .\Get-WindowsUpdateHistory.ps1 -Days 30 -OutputPath C:\Temp\UpdateHistory.csv
.NOTES
    Author: Xuan Toan Nguyen | #ToanNguyenITOz
#>
[CmdletBinding()]
param(
    [ValidateRange(1, 3650)]
    [int]$Days = 60,

    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$resultMap = @{
    0 = 'NotStarted'
    1 = 'InProgress'
    2 = 'Succeeded'
    3 = 'SucceededWithErrors'
    4 = 'Failed'
    5 = 'Aborted'
}

try {
    $session = New-Object -ComObject Microsoft.Update.Session
    $searcher = $session.CreateUpdateSearcher()
    $count = $searcher.GetTotalHistoryCount()
    $cutoff = (Get-Date).AddDays(-$Days)

    $history = if ($count -gt 0) { $searcher.QueryHistory(0, $count) } else { @() }

    $results = $history |
        Where-Object { $_.Date -ge $cutoff } |
        ForEach-Object {
            [pscustomobject]@{
                Date        = $_.Date
                Title       = $_.Title
                Result      = $resultMap[[int]$_.ResultCode]
                Operation   = [string]$_.Operation
                HResult     = ('0x{0:X8}' -f ([uint32]$_.HResult))
                SupportUrl  = $_.SupportUrl
                Description = $_.Description
            }
        } |
        Sort-Object Date -Descending

    $results | Format-Table Date, Result, HResult, Title -AutoSize

    if ($OutputPath) {
        $directory = Split-Path -Parent $OutputPath
        if ($directory -and -not (Test-Path $directory)) {
            New-Item -ItemType Directory -Path $directory -Force | Out-Null
        }
        $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
        Write-Host "History exported to $OutputPath"
    }
}
catch {
    Write-Error "Unable to read Windows Update history: $($_.Exception.Message)"
    exit 1
}
