function Get-HuduArticles {
    <#
    .SYNOPSIS
    Get Knowledge Base Articles

    .DESCRIPTION
    Calls Hudu API to retrieve KB articles by Id or a list

    .PARAMETER Id
    Id of the Article

    .PARAMETER CompanyId
    Filter by company id

    .PARAMETER Name
    Filter by name of article

    .PARAMETER Slug
    Filter by slug of article

    .EXAMPLE
    Get-HuduArticles -Name 'Article name'

    #>
    [CmdletBinding()]
    Param (
        [Int]$Id = '',
        [Alias('company_id')]
        [Int]$CompanyId = '',
        [String]$Name = '',
        [String]$Slug
    )

    if ($Id) {
        Invoke-HuduRequest -Method get -Resource "/api/v1/articles/$Id"
    } else {
        $Params = @{}

        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($Name) { $Params.name = $Name }
        if ($Slug) { $Params.slug = $Slug }

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/articles'
            Params   = $Params
        }

        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property articles
    }
}
