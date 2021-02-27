function Get-HuduApiKey {
	if($Int_HuduAPIKey -eq $null) {
		Write-Error "No API key has been set. Please use New-HuduAPIKey to set it."
	}
	else{
	$Int_HuduAPIKey
	}
}
