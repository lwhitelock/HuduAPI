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

    .PARAMETER StartDate
    Filter by updated_at property

    .PARAMETER EndDate
    Filter by updated_at property

    .PARAMETER ExactDate
    Filter by updated_at property

    .EXAMPLE
    Get-HuduCompanies -Search 'Vendor'

    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    Param (
        [Parameter(ParameterSetName = 'List')]
        [String]$Name = '',

        [Parameter(ParameterSetName = 'List')]
        [Alias('phone_number')]
        [String]$PhoneNumber = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$Website = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$City = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$State = '',

        [Parameter(ParameterSetName = 'List')]
        [Alias('id_in_integration')]
        [Int]$IdInIntegration = '',

        [Parameter(ParameterSetName = 'Single')]
        [Int]$Id = '',

        [Parameter(ParameterSetName = 'List')]
        [string]$Search,

        [Parameter(ParameterSetName = 'List')]
        [String]$Slug,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$StartDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$EndDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$ExactDate
    )

    if ($Id) {
        $Company = Invoke-HuduRequest -Method get -Resource "/api/v1/companies/$Id"
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

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/companies'
            Params   = $Params
        }

        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'companies'
    }
}
