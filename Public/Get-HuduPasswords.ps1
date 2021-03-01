function Get-HuduPasswords {
	Param (
		[Int]$id = '',
		[Int]$companyid = '',
		[String]$name =''
	
	)
	
	if ($id) {
		$password = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_passwords/$id"
		return $password
	} else {

		$resourcefilter = ''

		if ($companyid) {
			$resourcefilter = "$($resourcefilter)&companyid=$($companyid)"
		}

		if ($name) {
			$resourcefilter = "$($resourcefilter)&name=$($name)"
		}
	
		$i = 1;
		$AllPasswords = do {
			$Passwords = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_passwords?page=$i&page_size=1000$($resourcefilter)"
			$i++
			$Passwords.asset_passwords
		} while ($Passwords.asset_passwords.count % 1000 -eq 0 -and $Passwords.asset_passwords.count -ne 0)
		
	
		return $AllPasswords
	
	}
}