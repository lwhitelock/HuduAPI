function Invoke-HuduRequest {
	[CmdletBinding()]
	Param(
		[string]$Method,
		[string]$Resource,
		[string]$Body,
		[hashtable]$Form

	)
	
	write-verbose "Method: $Method"
	write-verbose "Resource: $Resource"
	write-verbose "Body: $($Body | out-string)"
	write-verbose "BaseURL: $(Get-HuduBaseURL)"
	write-verbose "Form: $($form | out-string)"

	try {
		$HuduAPIKey = Get-HuduApiKey
		$HuduBaseURL = Get-HuduBaseURL
		if (($Method -eq "put") -or ($Method -eq "post") -or ($Method -eq "delete")) {
			if ($Form) {
				$HuduResult = Invoke-RestMethod -method $method -uri ($HuduBaseURL + $Resource) `
				-headers @{'x-api-key' = (New-Object PSCredential "user", $HuduAPIKey).GetNetworkCredential().Password; `
				'Content-Type' = 'multipart/form-data'}	-Form $Form
			}
			else {
				$HuduResult = Invoke-RestMethod -method $method -uri ($HuduBaseURL + $Resource) `
				-headers @{'x-api-key' = (New-Object PSCredential "user", $HuduAPIKey).GetNetworkCredential().Password; } `
				-ContentType 'application/json; charset=utf-8' -body $Body
			}			

		} else {	
			$HuduResult = Invoke-RestMethod -method $method -uri ($HuduBaseURL + $Resource) `
				-headers @{'x-api-key' = (New-Object PSCredential "user", $HuduAPIKey).GetNetworkCredential().Password; } `
				-ContentType 'application/json; charset=utf-8'
		}


	} catch {
		if ("$_".trim() -eq "Retry later" -or "$_".trim() -eq "The remote server returned an error: (429) Too Many Requests.") {
			Write-Host "Hudu API Rate limited. Waiting 30 Seconds then trying again" -foregroundcolor red
			Start-Sleep 30
			$HuduResult = Invoke-HuduRequest -Method $method -Resource $resource -Body $Body
		} else {
			Write-Error "'$_'"
		}
	}
	
	return $HuduResult
	
}
