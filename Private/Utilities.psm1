function New-HuduAPIKey {
	Param (
		[Parameter(Mandatory=$false,
		ValueFromPipeline=$true)]
		[String]
		$ApiKey
		)
		
	if ($ApiKey) {
		$SecApiKey = ConvertTo-SecureString $ApiKey -AsPlainText -Force
	}
	else {
		Write-Host "Please enter your Hudu API key, you can obtain it from https://your-hudu-domain/admin/api_keys:"
		$SecApiKey = Read-Host -AsSecureString
	}
	Set-Variable -Name "Int_HuduAPIKey" -Value $SecApiKey -Visibility Private -Scope global -Force
}

function Get-HuduApiKey {
	if($Int_HuduAPIKey -eq $null) {
		Write-Error "No API key has been set. Please use New-HuduAPIKey to set it."
	}
	else{
	$Int_HuduAPIKey
	}
}

function Remove-HuduAPIKey {
	Set-Variable -Name "Int_HuduAPIKey" -Value $null -Visibility Private -Scope global -Force
}

function New-HuduBaseURL {
	Param (
		[Parameter(Mandatory=$false,
		ValueFromPipeline=$true)]
		[String]
		$BaseURL
		)
		
	if (!$BaseURL) {
		Write-Host "Please enter your Hudu Base URL with no trailing /, for example https://demo.huducloud.com :"
		$BaseURL = Read-Host
	}
	Set-Variable -Name "Int_HuduBaseURL" -Value $BaseURL -Visibility Private -Scope global -Force
}

function Get-HuduBaseURL {
	if($Int_HuduBaseURL -eq $null) {
		Write-Error "No Base URL has been set. Please use New-HuduBaseURL to set it."
	}
	else{
	$Int_HuduBaseURL
	}
}

function Remove-HuduBaseURL {
	Set-Variable -Name "Int_HuduBaseURL" -Value $null -Visibility Private -Scope global -Force
}

function hudu_request {
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
	
