function Remove-HuduMagicDash {
	[CmdletBinding()]
	Param (
		[String]$Title = '',
		[Alias("company_name")]
		[String]$CompanyName = '',
		[String]$Id = ''
	)
	
	if ($id) {
		$null = Invoke-HuduRequest -Method delete -Resource "/api/v1/magic_dash/$Id"
	
	} else {

		if ($Title -and $CompanyName) {
	
			$MagicDash = @{}
	
			$MagicDash.add('title', $Title)
			$MagicDash.add('company_name', $CompanyName)
				
			$JSON = $MagicDash | convertto-json
	
			$null = Invoke-HuduRequest -Method delete -Resource "/api/v1/magic_dash" -body $JSON
	
		} else {
			Write-Host "ERROR: Please set title and company_name" -ForegroundColor Red
		}
	
	}
}