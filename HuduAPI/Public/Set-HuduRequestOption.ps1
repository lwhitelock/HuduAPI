function Set-HuduRequestOption {
    <#
    .SYNOPSIS
    Set options for how requests to the Hudu API are made

    .DESCRIPTION
    A failed request (other than a rate-limited one) is retried once after -RetryDelaySeconds. A POST that failed after
    Hudu had already created the record (for example a timeout) then creates it a second time; -SkipPostRetry turns the
    retry off for POST requests only.

    A rate-limited request waits until the next rate limit window starts (plus a few seconds of jitter), then is retried.
    Windows are -RateLimitWindowSeconds long, counted from midnight.

    Only the options passed are changed. The current options are returned.

    .PARAMETER SkipPostRetry
    Do not retry a failed POST request. Default: $false

    .PARAMETER RetryDelaySeconds
    Seconds to wait before retrying a failed request. Default: 5

    .PARAMETER RateLimitWindowSeconds
    Length of the rate limit window, in seconds. Default: 300

    .EXAMPLE
    Set-HuduRequestOption -SkipPostRetry $true

    .EXAMPLE
    Set-HuduRequestOption -RetryDelaySeconds 2 -RateLimitWindowSeconds 60

    .NOTES
    The options last for the session, like the API key and base URL
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Scope = 'Function')]
    [CmdletBinding()]
    Param (
        [bool]$SkipPostRetry,

        [ValidateRange(0, 3600)]
        [int]$RetryDelaySeconds,

        [ValidateRange(1, 3600)]
        [int]$RateLimitWindowSeconds
    )

    if ($PSBoundParameters.ContainsKey('SkipPostRetry')) { $script:SKIP_HAPI_POST_RETRY = $SkipPostRetry }
    if ($PSBoundParameters.ContainsKey('RetryDelaySeconds')) { $script:HAPI_RETRY_DELAY_SECONDS = $RetryDelaySeconds }
    if ($PSBoundParameters.ContainsKey('RateLimitWindowSeconds')) { $script:HAPI_RATE_LIMIT_WINDOW_SECONDS = $RateLimitWindowSeconds }

    [pscustomobject]@{
        SkipPostRetry          = [bool]$script:SKIP_HAPI_POST_RETRY
        RetryDelaySeconds      = $script:HAPI_RETRY_DELAY_SECONDS ?? 5
        RateLimitWindowSeconds = $script:HAPI_RATE_LIMIT_WINDOW_SECONDS ?? 300
    }
}
