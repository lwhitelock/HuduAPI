function Set-HuduCompany {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [String]$Nickname = '',
	[Alias("company_type")]
	[String]$CompanyType = '',
        [Alias("address_line_1")]
        [String]$AddressLine1 = '',
        [Alias("address_line_2")]
        [String]$AddressLine2 = '',
        [String]$City = '',
        [String]$State = '',
        [Alias("PostalCode", "PostCode")]
        [String]$Zip = '',
        [Alias("country_name")]
        [String]$CountryName = '',
        [Alias("phone_number")]
        [String]$PhoneNumber = '',
        [Alias("fax_number")]
        [String]$FaxNumber = '',
        [String]$Website = '',
        [Alias("id_number")]
        [String]$IdNumber = '',
	[Alias("parent_company_id")]
	[Int]$ParentCompanyId,
        [String]$Notes = ''
    )
	

    $Company = [ordered]@{company = [ordered]@{} }
	
    $Company.company.add('name', $Name)
    $Company.company.add('nickname', $Nickname)
    $Company.company.add('company_type', $CompanyType)
    $Company.company.add('address_line_1', $AddressLine1)
    $Company.company.add('address_line_2', $AddressLine2)
    $Company.company.add('city', $City)
    $Company.company.add('state', $State)
    $Company.company.add('zip', $Zip)
    $Company.company.add('country_name', $CountryName)
    $Company.company.add('phone_number', $PhoneNumber)
    $Company.company.add('fax_number', $FaxNumber)
    $Company.company.add('website', $Website)
    $Company.company.add('id_number', $IdNumber)
    $Company.company.add('parent_company_id', $ParentCompanyId)
    $Company.company.add('notes', $Notes)
	
    $JSON = $Company | ConvertTo-Json -Depth 10
	
    $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$Id" -body $JSON
	
    $Response
}
