function Invoke-HuduRequest {
	Param(
		[string]$Method,
		[string]$Resource,
		[string]$Body
	)
	
	if (($Method -eq "put") -or ($Method -eq "post") -or ($Method -eq "delete")) {
		try {
		$HuduAPIKey = Get-HuduApiKey
		$HuduBaseURL = Get-HuduBaseURL

		$HuduResult = Invoke-RestMethod -method $method -uri ($HuduBaseURL + $Resource) `
			-headers @{'x-api-key' = (New-Object PSCredential "user",$HuduAPIKey).GetNetworkCredential().Password;} `
			-ContentType 'application/json' -body $Body
		} catch {
			Write-Error $_
		}
	} else {	
		try {
		$HuduAPIKey = Get-HuduApiKey
		$HuduBaseURL = Get-HuduBaseURL
		$HuduResult = Invoke-RestMethod -method $method -uri ($HuduBaseURL + $Resource) `
			-headers @{'x-api-key' = (New-Object PSCredential "user",$HuduAPIKey).GetNetworkCredential().Password;} `
			-ContentType 'application/json'
		} catch {
			Write-Error $_
		}
	}
	
	return $HuduResult
	
}