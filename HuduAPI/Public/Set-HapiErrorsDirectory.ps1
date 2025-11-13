function Set-HapiErrorsDirectory {
    param(
        [Parameter()][string]$Path=$null,
        [Parameter()][bool]$skipRetry=$false,
        [Parameter()][ValidateSet("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White",$null)]
        [string]$Color=$null)
    if ([string]::IsNullOrWhiteSpace($Path)) {
        $Path = $script:HAPI_ERRORS_DIRECTORY ?? (Join-Path -Path $($env:LOCALAPPDATA) -ChildPath "$($("$(Get-HuduBaseURL)" -replace "https://",'') -replace "/",'')-errors")
    }
    if (!(Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
    try {
        $Path = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).ProviderPath
    } catch {
        $Path = $path
    }    
    $script:HAPI_ERRORS_DIRECTORY = $Path

    if ($null -ne $skipRetry) {
        $script:SKIP_HAPI_ERROR_RETRY = $skipRetry
    } else {
        $script:SKIP_HAPI_ERROR_RETRY = $script:SKIP_HAPI_ERROR_RETRY ?? $false
    }
    if ($Color -and @("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White") -contains $Color) {
        $script:HAPI_ERROR_COLOR = $Color
    } else {
        $script:HAPI_ERROR_COLOR = $script:HAPI_ERROR_COLOR  ?? "DarkCyan"
    }
    return [pscustomobject]@{
        Path        = $script:HAPI_ERRORS_DIRECTORY
        SkipRetry   = $script:SKIP_HAPI_ERROR_RETRY
        Color       = $script:HAPI_ERROR_COLOR
    }
}
