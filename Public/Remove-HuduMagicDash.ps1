function remove-HuduMagicDash {
	Param (
		[String]$title = '',
		[String]$company_name = '',
		[String]$id = ''
	)
	
	if ($id) {
		$null = Invoke-HuduRequest -Method delete -Resource "/api/v1/magic_dash/$id"
	
	}
 else {

		if ($title -and $company_name) {
	
			$magicdash = @{}
	
			$magicdash.add('title', $title)
			$magicdash.add('company_name', $company_name)
				
			$json = $magicdash | convertto-json
	
			$null = Invoke-HuduRequest -Method delete -Resource "/api/v1/magic_dash" -body $json
	
		}
		else {
			Write-Host "ERROR: Please set title and company_name" -ForegroundColor Red
		}
	
	}
}