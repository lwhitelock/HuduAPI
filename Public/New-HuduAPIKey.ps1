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
	Set-Variable -Name "Int_HuduAPIKey" -Value $SecApiKey -Visibility Private -Scope script -Force

	if ($script:Int_HuduBaseURL){
		[version]$version = (Get-HuduAppInfo).version
		if ($version -lt $script:HuduRequiredVersion){
			Write-Host "This version of the powershell module requires Hudu version $script:HuduRequiredVersion Please update." -foregroundcolor yellow
		}
	}
}