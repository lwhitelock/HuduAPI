function Get-HuduExpirations {
    <#
    .SYNOPSIS
    Get expirations for account

    .DESCRIPTION
    Calls Hudu API to retrieve expirations

    .PARAMETER CompanyId
    Filter expirations by company_id

    .PARAMETER ExpirationType
    Filter expirations by expiration type (undeclared, domain, ssl_certificate, warranty, asset_field, article_expiration)

    .PARAMETER ResourceId
    Filter logs by resource id. Must be coupled with resource_type

    .PARAMETER ResourceType
    Filter logs by resource type (Asset, AssetPassword, Company, Article, etc.). Must be coupled with resource_id

    .EXAMPLE
    Get-HuduExpirations -ExpirationType domain

    #>
    [CmdletBinding()]
    Param (
        [Alias('company_id')]
        [Int]$CompanyId = '',

        [ValidateSet('undeclared', 'domain', 'ssl_certificate', 'warranty', 'asset_field', 'article_expiration')]
        [Alias('expiration_type')]
        [String]$ExpirationType = '',

        [Alias('resource_id')]
        [Int]$ResourceId = '',

        [Alias('resource_type')]
        [String]$ResourceType = ''
    )

    $Params = @{}

    if ($CompanyId) { $Params.company_id = $CompanyId }
    if ($ExpirationType) { $Params.expiration_type = $ExpirationType }
    if ($ResourceType) { $Params.resource_type = $ResourceType }
    if ($ResourceId) { $Params.resource_id = $ResourceId }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/expirations'
        Params   = $Params
    }

    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest
}
