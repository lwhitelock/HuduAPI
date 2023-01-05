function Get-HuduWebsites {
	[CmdletBinding()]
	Param (
		[String]$Name = '',
		[Alias("website_id")]
		[String]$WebsiteId = '',
		[Int]$id = '',
		[String]$Slug
	)
	
	if ($WebsiteId) {
		$Website = Invoke-HuduRequest -Method get -Resource "/api/v1/websites/$($WebsiteId)"
		return $Website
	} else {
		
	
		$ResourceFilter = ''
	
		if ($Name) {
			$ResourceFilter = "&name=$($Name)"	
		}

		if ($Slug) {
			$ResourceFilter = "$($ResourceFilter)&slug=$($Slug)"
		}	
		
		$i = 1;
		$AllWebsites = do {
			$Websites = Invoke-HuduRequest -Method get -Resource "/api/v1/websites?page=$i&page_size=1000$($ResourceFilter)"
			$i++
			$Websites
		} while ($Websites.websites.count % 1000 -eq 0 -and $Websites.websites.count -ne 0)
		
			
		return $AllWebsites
		
	
	}
}