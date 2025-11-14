
function Write-APIErrorObject {
    param (
        [Parameter(Mandatory)]
        [object]$ErrorObject,

        [Parameter()]
        [string]$Name = "unnamed",

        [Parameter()]
        [ValidateSet("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White")]
        [string]$Color

    )
    <#
    .SYNOPSIS
    Unwraps and prints an object, error, and logs error to a specific file safely.
#>
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
    if ([string]::IsNullOrWhiteSpace($script:HAPI_ERRORS_DIRECTORY)) {Set-HapiErrorsDirectory}

    $SafeName = ($Name -replace '[\\/:*?"<>|]', '_') -replace '\s+', ''
    if ($SafeName.Length -gt 60) {
        $SafeName = $SafeName.Substring(0, 60)
    }
    $fullPath = Join-Path $script:HAPI_ERRORS_DIRECTORY "${SafeName}_error_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
    Set-Content -Path $fullPath -Value $logContent -Encoding UTF8

    if ($script:HAPI_ERROR_COLOR -and @("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White") -contains $script:HAPI_ERROR_COLOR) {
        Write-Host "$logContent`nError written to $fullPath" -ForegroundColor $script:HAPI_ERROR_COLOR
    } elseif ($Color) {
        Write-Host "$logContent`nError written to $fullPath" -ForegroundColor $Color
    } else {
        Write-Host "$logContent"
    }
}
