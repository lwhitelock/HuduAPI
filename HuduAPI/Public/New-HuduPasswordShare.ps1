function New-HuduPasswordShare {
    <#
    .SYNOPSIS
    Create a sharing link for a password.

    .DESCRIPTION
    Creates a time-limited public sharing link for a password and returns the
    sharing link object, including its full public url. ExpireIn must be a
    positive number of seconds; links that never expire are not permitted.
    Optional fields are sent only when supplied, preserving Hudu's defaults.
    Requires an API key with access to passwords and external sharing enabled
    for the account. Hudu returns HTTP 403 when external sharing is disabled.

    .PARAMETER AssetPasswordId
    ID of the password to share.

    .PARAMETER ExpireIn
    Positive number of seconds until the sharing link expires.

    .PARAMETER Notes
    Notes for the sharing link.

    .PARAMETER OneTimeExpire
    Whether the sharing link expires after it is viewed once.

    .PARAMETER IncludeUsername
    Whether to include the password's username in the shared view.

    .PARAMETER IncludeOTP
    Whether to include the password's one-time password in the shared view.

    .PARAMETER IncludeURL
    Whether to include the password's URL in the shared view.

    .PARAMETER IncludeNotes
    Whether to include the password's notes in the shared view.

    .EXAMPLE
    New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 3600

    Creates a sharing link that expires after one hour.

    .EXAMPLE
    $Share = New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 86400 -OneTimeExpire $true -IncludeUsername $true -IncludeOTP $false
    $Share.url

    Creates a one-time sharing link valid for up to one day and retrieves its URL.

    .OUTPUTS
    System.Management.Automation.PSCustomObject

    .NOTES
    API Endpoint: POST /api/v1/asset_passwords/{asset_password_id}/shares
    #>
    [CmdletBinding(SupportsShouldProcess)]
    # AssetPasswordId and IncludeUsername are share settings, not credential inputs.
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '')]
    param (
        [Parameter(Mandatory = $true)]
        [Alias('PasswordId', 'asset_password_id')]
        [ValidateRange(1, [long]::MaxValue)]
        [long]$AssetPasswordId,

        [Parameter(Mandatory = $true)]
        [Alias('expire_in')]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$ExpireIn,

        [string]$Notes,

        [Alias('one_time_expire')]
        [bool]$OneTimeExpire,

        [Alias('include_username')]
        [bool]$IncludeUsername,

        [Alias('include_otp')]
        [bool]$IncludeOTP,

        [Alias('include_url')]
        [bool]$IncludeURL,

        [Alias('include_notes')]
        [bool]$IncludeNotes
    )

    $Share = [ordered]@{ expire_in = $ExpireIn }
    if ($PSBoundParameters.ContainsKey('Notes'))           { $Share.notes = $Notes }
    if ($PSBoundParameters.ContainsKey('OneTimeExpire'))   { $Share.one_time_expire = $OneTimeExpire }
    if ($PSBoundParameters.ContainsKey('IncludeUsername')) { $Share.include_username = $IncludeUsername }
    if ($PSBoundParameters.ContainsKey('IncludeOTP'))      { $Share.include_otp = $IncludeOTP }
    if ($PSBoundParameters.ContainsKey('IncludeURL'))      { $Share.include_url = $IncludeURL }
    if ($PSBoundParameters.ContainsKey('IncludeNotes'))    { $Share.include_notes = $IncludeNotes }

    $JSON = @{ share = $Share } | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess("Password ID $AssetPasswordId", 'Create sharing link')) {
        $Response = Invoke-HuduRequest -Method POST -Resource "/api/v1/asset_passwords/$AssetPasswordId/shares" -Body $JSON
        return $Response.share
    }
}
