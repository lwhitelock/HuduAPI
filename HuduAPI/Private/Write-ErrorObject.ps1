function Write-APIErrorObject {
    param (
        [Parameter(Mandatory)]
        [object]$ErrorObject,

        [Parameter()]
        [string]$Name = "Unnamed"
    )

    $stringOutput = try {
        $ErrorObject | Format-List -Force | Out-String
    } catch {
        "Failed to stringify object: $_"
    }

    $propertyDump = try {
        $props = $ErrorObject | Get-Member -MemberType Properties | Select-Object -ExpandProperty Name
        $lines = foreach ($p in $props) {
            try {
                "$p = $($ErrorObject.$p)"
            } catch {
                "$p = <unreadable>"
            }
        }
        $lines -join "`n"
    } catch {
        "Failed to enumerate properties: $_"
    }

    $logContent = @"
==== OBJECT STRING ====
$stringOutput

==== PROPERTY DUMP ====
$propertyDump
"@

    if ($global:HAPI_ERRORS_DIRECTORY -and (Test-Path $global:HAPI_ERRORS_DIRECTORY)) {
        $filename = "$($Name.Trim())_error_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
        $fullPath = Join-Path $global:HAPI_ERRORS_DIRECTORY $filename
        Set-Content -Path $fullPath -Value $logContent -Encoding UTF8
        Write-Host "Error written to $fullPath" -ForegroundColor Yellow
    }

    Write-Host "$logContent" -ForegroundColor Yellow
}