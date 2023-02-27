function New-HuduCompany {
    <#
    .SYNOPSIS
    Create a company

    .DESCRIPTION
    Uses Hudu API to create a new company

    .PARAMETER Name
    Company name

    .PARAMETER Nickname
    Company nickname

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
    Country

    .PARAMETER PhoneNumber
    Phone number

    .PARAMETER FaxNumber
    Fax number

    .PARAMETER Website
    Website

    .PARAMETER IdNumber
    Company id number

    .PARAMETER ParentCompanyId
    Parent company id number

    .PARAMETER Notes
    Parameter description

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    New-HuduCompany -Name 'Company name'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
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
        [int]$ParentCompanyId,

        [String]$Notes = '',

        [string]$Slug
    )


    $Company = [ordered]@{company = [ordered]@{} }

    $Company.company.add('name', $Name)
    if (-not ([string]::IsNullOrEmpty($Nickname))) { $Company.company.add('nickname', $Nickname) }
    if (-not ([string]::IsNullOrEmpty($Nickname))) { $Company.company.add('company_type', $CompanyType) }
    if (-not ([string]::IsNullOrEmpty($AddressLine1))) { $Company.company.add('address_line_1', $AddressLine1) }
    if (-not ([string]::IsNullOrEmpty($AddressLine2))) { $Company.company.add('address_line_2', $AddressLine2) }
    if (-not ([string]::IsNullOrEmpty($City))) { $Company.company.add('city', $City) }
    if (-not ([string]::IsNullOrEmpty($State))) { $Company.company.add('state', $State) }
    if (-not ([string]::IsNullOrEmpty($Zip))) { $Company.company.add('zip', $Zip) }
    if (-not ([string]::IsNullOrEmpty($CountryName))) { $Company.company.add('country_name', $CountryName) }
    if (-not ([string]::IsNullOrEmpty($PhoneNumber))) { $Company.company.add('phone_number', $PhoneNumber) }
    if (-not ([string]::IsNullOrEmpty($FaxNumber))) { $Company.company.add('fax_number', $FaxNumber) }
    if (-not ([string]::IsNullOrEmpty($Website))) { $Company.company.add('website', $Website) }
    if (-not ([string]::IsNullOrEmpty($IdNumber))) { $Company.company.add('id_number', $IdNumber) }
    if (-not ([string]::IsNullOrEmpty($ParentCompanyId))) { $Company.company.add('parent_company_id', $ParentCompanyId) }
    if (-not ([string]::IsNullOrEmpty($Notes))) { $Company.company.add('notes', $Notes) }
    if (-not ([string]::IsNullOrEmpty($Slug))) { $Company.company.add('slug', $Slug) }

    $JSON = $Company | ConvertTo-Json -Depth 10
    Write-Verbose $JSON

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method post -Resource '/api/v1/companies' -Body $JSON
    }
}
