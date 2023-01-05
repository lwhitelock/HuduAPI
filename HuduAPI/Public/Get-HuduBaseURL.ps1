function Get-HuduBaseURL {
	[CmdletBinding()]
	Param()
	if ($null -eq $Int_HuduBaseURL) {
		Write-Error "No Base URL has been set. Please use New-HuduBaseURL to set it."
	} else {
		$Int_HuduBaseURL
	}
}
