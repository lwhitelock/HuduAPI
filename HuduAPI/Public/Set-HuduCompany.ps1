function Set-HuduCompany {
    <#
    .SYNOPSIS
    Update a company

    .DESCRIPTION
    Uses Hudu API to update a Company

    .PARAMETER Id
    Id of the requested company

    .PARAMETER Name
    Name of the company

    .PARAMETER Nickname
    Nickname of the company

    .PARAMETER CompanyType
    Company type

    .PARAMETER AddressLine1
    Address line 1

    .PARAMETER AddressLine2
    Address line 2

    .PARAMETER City
    City

    .PARAMETER State
    State

    .PARAMETER Zip
    Zip

    .PARAMETER CountryName
    Country name

    .PARAMETER PhoneNumber
    Phone number

    .PARAMETER FaxNumber
    Fax number

    .PARAMETER Website
    Webste

    .PARAMETER IdNumber
    Id number

    .PARAMETER ParentCompanyId
    Parent company id

    .PARAMETER Notes
    Company notes

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    Set-HuduCompany -Id 1 -Name 'New company name'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,

        [String]$Name,

        [String]$Nickname = '',

        [Alias('company_type')]
        [String]$CompanyType = '',

        [Alias('address_line_1')]
        [String]$AddressLine1 = '',

        [Alias('address_line_2')]
        [String]$AddressLine2 = '',

        [String]$City = '',

        [String]$State = '',

        [Alias('PostalCode', 'PostCode')]
        [String]$Zip = '',

        [Alias('country_name')]
        [String]$CountryName = '',

        [Alias('phone_number')]
        [String]$PhoneNumber = '',

        [Alias('fax_number')]
        [String]$FaxNumber = '',

        [String]$Website = '',

        [Alias('id_number')]
        [String]$IdNumber = '',

        [Alias('parent_company_id')]
        [Int]$ParentCompanyId,

        [String]$Notes = '',

        [string]$Slug
    )

    $Object = Get-HuduCompanies -Id $Id

    $Company = [ordered]@{company = $Object }

    if ($Name) {
        $Company.company.name = $Name
    }

    if ($Nickname) {
        $Company.company.nickname = $Nickname
    }

    if ($CompanyType) {
        $Company.company.company_type = $CompanyType
    }

    if ($AddressLine1) {
        $Company.company.address_line_1 = $AddressLine1
    }

    if ($AddressLine2) {
        $Company.company.address_line_2 = $AddressLine2
    }

    if ($City) {
        $Company.company.city = $City
    }
    
    if ($State) {
        $Company.company.state = $State
    }

    if ($Zip) {
        $Company.company.zip = $Zip
    }

    if ($CountryName) {
        $Company.company.country_name = $CountryName
    }

    if ($PhoneNumber) {
        $Company.company.phone_number = $PhoneNumber
    }

    if ($FaxNumber) {
        $Company.company.fax_number = $FaxNumber
    }

    if ($Website) {
        $Company.company.website = $Website
    }

    if ($IdNumber) {
        $Company.company.id_number = $IdNumber
    }

    if ($ParentCompanyId) {
        $Company.company.parent_company_id = $ParentCompanyId
    }

    if ($Notes) {
        $Company.company.notes = $Notes
    }

    if ($Slug) {
        $Company.company.slug = $Slug
    }

    $JSON = $Company | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$Id" -Body $JSON
    }
}
