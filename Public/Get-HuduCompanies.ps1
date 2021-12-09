function Get-HuduCompanies {
	[CmdletBinding()]
	Param (
		[String]$Name = '',
		[Alias("phone_number")]
		[String]$PhoneNumber = '',
		[String]$Website = '',
		[String]$City = '',
		[String]$State = '',
		[Alias("id_in_integration")]
		[Int]$IdInIntegration = '',
		[Int]$Id = ''
	
	)


	if ($Id) {
		$Company = Invoke-HuduRequest -Method get -Resource "/api/v1/companies/$Id"
		return $Company
	} else {
	
		$ResourceFilter = ''
	
		if ($Name) {
			$ResourceFilter = "$($ResourceFilter)&name=$($Name)"
		}
	
		if ($PhoneNumber) {
			$ResourceFilter = "$($ResourceFilter)&phone_number=$($PhoneNumber)"
		}
	
		if ($Website) {
			$ResourceFilter = "$($ResourceFilter)&website=$($Website)"
		}
	
		if ($City) {
			$ResourceFilter = "$($ResourceFilter)&city=$($City)"
		}
	
		if ($City) {
			$ResourceFilter = "$($ResourceFilter)&state=$($City)"
		}
	
		if ($IdInIntegration) {
			$ResourceFilter = "$($ResourceFilter)&id_in_integration=$($IdInIntegration)"
		}
	
	
	
		$i = 1;
		$AllCompanies = do {
			$Companies = Invoke-HuduRequest -Method get -Resource "/api/v1/companies?page=$i&page_size=1000$($ResourceFilter)"
			$i++
			$Companies.Companies
		} while ($Companies.Companies.count % 1000 -eq 0 -and $Companies.Companies.count -ne 0)
		
			
		return $AllCompanies
	
	}
}