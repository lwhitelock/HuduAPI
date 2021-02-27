function Get-HuduWebsites {
	Param (
		[String]$name ='',
		[String]$websiteid='',
		[Int]$id=''
	)
	
	if ($websiteid) {
		$Website = Invoke-HuduRequest -Method get -Resource "/api/v1/websites/$($websiteid)"
		return $Website
	} else {
		
	
	$resourcefilter = ''
	
	if ($name) {
		$resourcefilter = "&name=$($name)"	
	}
		
	$i = 1;
		$AllWebsites = do {
		$Websites = Invoke-HuduRequest -Method get -Resource "/api/v1/websites?page=$i&page_size=1000$($resourcefilter)"
		$i++
		$Websites
		} while ($Websites.websites.count % 1000 -eq 0 -and $Websites.websites.count -ne 0)
		
			
	return $AllWebsites
		
	
	}
}
