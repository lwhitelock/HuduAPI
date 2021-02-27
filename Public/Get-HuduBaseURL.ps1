function Get-HuduBaseURL {
	if($Int_HuduBaseURL -eq $null) {
		Write-Error "No Base URL has been set. Please use New-HuduBaseURL to set it."
	}
	else{
	$Int_HuduBaseURL
	}
}
