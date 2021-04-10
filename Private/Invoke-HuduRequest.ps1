function Invoke-HuduRequest {
	Param(
		[string]$Method,
		[string]$Resource,
		[string]$Body
	)
	
	try {
		if (($Method -eq "put") -or ($Method -eq "post") -or ($Method -eq "delete")) {
			$HuduAPIKey = Get-HuduApiKey
			$HuduBaseURL = Get-HuduBaseURL
			$HuduResult = Invoke-RestMethod -method $method -uri ($HuduBaseURL + $Resource) `
				-headers @{'x-api-key' = (New-Object PSCredential "user",$HuduAPIKey).GetNetworkCredential().Password;} `
				-ContentType 'application/json' -body $Body			

		} else {	
			$HuduAPIKey = Get-HuduApiKey
			$HuduBaseURL = Get-HuduBaseURL
			$HuduResult = Invoke-RestMethod -method $method -uri ($HuduBaseURL + $Resource) `
				-headers @{'x-api-key' = (New-Object PSCredential "user",$HuduAPIKey).GetNetworkCredential().Password;} `
				-ContentType 'application/json'
		}


	} catch {
		if ("$_".trim() -eq "Retry later"){
			Write-Host "Hudu API Rate limited. Waiting 30 Seconds then trying again" -foregroundcolor red
			Start-Sleep 30
			$HuduResult = Invoke-HuduRequest -Method $method -Resource $resource -Body $Body
		} else {
			Write-Error "'$_'"
		}
	}
	
	return $HuduResult
	
}