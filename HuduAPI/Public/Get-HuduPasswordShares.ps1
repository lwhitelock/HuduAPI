function Get-HuduPasswordShares {
    <#
    .SYNOPSIS
    Get sharing links for a password.

    .DESCRIPTION
    Retrieves all sharing links for a password, ordered by ID, or a single sharing
    link by ID. Automatically retrieves every page unless Page is specified.
    Requires an API key with access to passwords.

    .PARAMETER AssetPasswordId
    ID of the password the sharing links belong to.

    .PARAMETER Id
    ID of a single sharing link to retrieve.

    .PARAMETER Page
    Return only this page of sharing links instead of retrieving every page.

    .PARAMETER PageSize
    Number of results per page, from 1 to 1000. Defaults to 1000.

    .EXAMPLE
    Get-HuduPasswordShares -AssetPasswordId 42

    Retrieves every sharing link for password 42.

    .EXAMPLE
    Get-HuduPasswordShares -AssetPasswordId 42 -Id 7

    Retrieves sharing link 7 for password 42.

    .EXAMPLE
    Get-HuduPasswordShares -AssetPasswordId 42 -Page 2 -PageSize 25

    Retrieves only the second page of 25 sharing links.

    .OUTPUTS
    System.Management.Automation.PSCustomObject

    .NOTES
    API Endpoints:
    GET /api/v1/asset_passwords/{asset_password_id}/shares
    GET /api/v1/asset_passwords/{asset_password_id}/shares/{id}
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    # Match the module's plural names for commands that retrieve collections.
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param (
        [Parameter(Mandatory = $true)]
        [Alias('PasswordId', 'asset_password_id')]
        [ValidateRange(1, [long]::MaxValue)]
        [long]$AssetPasswordId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ById')]
        [Alias('ShareId', 'share_id')]
        [ValidateRange(1, [long]::MaxValue)]
        [long]$Id


    )

    $Resource = "/api/v1/asset_passwords/$AssetPasswordId/shares"
    if ($PSCmdlet.ParameterSetName -eq 'ById') {
        $Response = Invoke-HuduRequest -Method GET -Resource "$Resource/$Id"
        return $Response.share
    }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = $Resource
        Params   = @{}
    }

    $Response = Invoke-HuduRequest @HuduRequest
    return $Response.shares
}
