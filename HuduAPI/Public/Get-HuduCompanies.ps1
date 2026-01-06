function Get-HuduCompanies {
    <#
    .SYNOPSIS
    Get a list of companies

    .DESCRIPTION
    Call Hudu API to retrieve company list

    .PARAMETER Id
    Filter companies by id

    .PARAMETER Name
    Filter companies by name

    .PARAMETER PhoneNumber
    filter companies by phone number

    .PARAMETER Website
    Filter companies by website

    .PARAMETER City
    Filter companies by city

    .PARAMETER State
    Filter companies by state

    .PARAMETER Search
    Filter by search query

    .PARAMETER Slug
    Filter by url slug

    .PARAMETER IdInIntegration
    Filter companies by id/identifier in PSA/RMM/outside integration

    .PARAMETER UpdatedAfter
    Get Companies Updated After X datetime
    
    .PARAMETER UpdatedBefore
    Get Companies Updated Before Y datetime

    .EXAMPLE
    Get-HuduCompanies -Search 'Vendor'
    Get-HuduCompanies -Updatedafter $(get-date).Addyears(-1)

    #>
    [CmdletBinding()]
    Param (
        [String]$Name = '',
        [Alias('phone_number')]
        [String]$PhoneNumber = '',
        [String]$Website = '',
        [String]$City = '',
        [String]$State = '',
        [Alias('id_in_integration')]
        [Int]$IdInIntegration = '',
        [Int]$Id = '',
        [string]$Search,
        [String]$Slug,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore
    )

    if ($Id) {
        $Company = (Invoke-HuduRequest -Method get -Resource "/api/v1/companies/$Id").company
        return $Company
    } else {
        $Params = @{}
        if ($Name) { $Params.name = $Name }
        if ($PhoneNumber) { $Params.phone_number = $PhoneNumber }
        if ($Website) { $Params.website = $Website }
        if ($City) { $Params.city = $City }
        if ($State) { $Params.state = $State }
        if ($IdInIntegration) { $Params.id_in_integration = $IdInIntegration }
        if ($Search) { $Params.search = $Search }
        if ($Slug) { $Params.slug = $Slug }
        $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
        if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
            $Params.updated_at = $updatedRange
        }

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/companies'
            Params   = $Params
        }

        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'companies'
    }
}
