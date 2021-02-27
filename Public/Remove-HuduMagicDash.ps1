function remove-HuduMagicDash {
	Param (
		[String]$title ='',
		[String]$company_name='',
		[String]$id=''
	)
	
	if ($id) {
	$response = Invoke-HuduRequest -Method delete -Resource "/api/v1/magic_dash/$id"
	
	} else {
	
	$magicdash = @{}
	
	if ($title) {
		$magicdash.add('title',$title)
	}
	
	if ($company_name) {
		$magicdash.add('company_name',$company_name)
	}
	
	$json = $magicdash | convertto-json
	
	$response = Invoke-HuduRequest -Method delete -Resource "/api/v1/magic_dash" -body $json
	
	}
	
}