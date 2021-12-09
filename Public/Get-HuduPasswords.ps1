function Get-HuduPasswords {
	[CmdletBinding()]
	Param (
		[Int]$Id = '',
		[Alias("company_id")]
		[Int]$CompanyId = '',
		[String]$Name = ''
	
	)
	
	if ($Id) {
		$Password = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_passwords/$id"
		return $Password
	} else {

		$ResourceFilter = ''

		if ($CompanyId) {
			$ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
		}

		if ($Name) {
			$ResourceFilter = "$($ResourceFilter)&name=$($Name)"
		}
	
		$i = 1;
		$AllPasswords = do {
			$Passwords = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_passwords?page=$i&page_size=1000$($ResourceFilter)"
			$i++
			$Passwords.asset_passwords
		} while ($Passwords.asset_passwords.count % 1000 -eq 0 -and $Passwords.asset_passwords.count -ne 0)
		
	
		return $AllPasswords
	
	}
}