function Get-HuduPasswords {
    <#
    .SYNOPSIS
    Get a list of Passwords

    .DESCRIPTION
    Calls Hudu API to list password assets

    .PARAMETER Id
    Id of the password

    .PARAMETER CompanyId
    Filter by company id

    .PARAMETER Name
    Filter by password name

    .PARAMETER Slug
    Filter by url slug

    .PARAMETER Search
    Filter by search query

    .EXAMPLE
    Get-HuduPasswords -CompanyId 1

    #>
    [CmdletBinding()]
    Param (
        [Int]$Id,

        [Alias('company_id')]
        [Int]$CompanyId,

        [String]$Name,

        [String]$Slug,

        [string]$Search
    )

    if ($Id) {
        $Password = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_passwords/$id"
        return $Password
    } else {
        $Params = @{}
        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($Name) { $Params.name = $Name }
        if ($Slug) { $Params.slug = $Slug }
        if ($Search) { $Params.search = $Search }
    }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/asset_passwords'
        Params   = $Params
    }
    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'asset_passwords'
}
