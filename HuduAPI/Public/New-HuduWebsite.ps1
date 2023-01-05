function New-HuduWebsite {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[String]$Notes = '',
		[String]$Paused = '',
		[Alias("company_id")]
		[Parameter(Mandatory = $true)]
		[Int]$CompanyId,
		[Alias("disable_dns")]
		[String]$DisableDNS = '',
		[Alias("disable_ssl")]
		[String]$DisableSSL = '',
		[Alias("disable_whois")]
		[String]$DisableWhois = ''
	)
	
	$Website = [ordered]@{website = [ordered]@{} }
	
	$Website.website.add('name', $Name)
		
	if ($Notes) {
		$Website.website.add('notes', $Notes)
	}
	
	if ($Paused) {
		$Website.website.add('paused', $Paused)
	}
	
	$Website.website.add('company_id', $CompanyId)
	
	if ($DisableDNS) {
		$Website.website.add('disable_dns', $DisableDNS)
	}
	
	if ($DisableSSL) {
		$Website.website.add('disable_ssl', $DisableSSL)
	}
	
	if ($DisableWhois) {
		$Website.website.add('disable_whois', $DisableWhois)
	}
	
	$JSON = $Website | ConvertTo-Json
	
	$Response = Invoke-HuduRequest -Method post -Resource "/api/v1/websites" -body $JSON
	
	$Response
	
}