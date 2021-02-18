function Get-HuduWebsites {
	Param (
		[String]$name ='',
		[String]$websiteid=''
	)
	
	if ($websiteid) {
		$Website = hudu_request -Method get -Resource "/api/v1/websites/$($websiteid)"
		return $Website
	} else {
		
	
	$resourcefilter = ''
	
	if ($name) {
		$resourcefilter = "&name=$($name)"	
	}
		
	$i = 0;
		$AllWebsites = do {
		$Websites = hudu_request -Method get -Resource "/api/v1/websites?page=$i&page_size=1000$($resourcefilter)"
		$i++
		$Websites
		} while ($Websites.websites.count % 1000 -eq 0 -and $Websites.websites.count -ne 0)
		
			
	return $AllWebsites
		
	
	}
}

function New-HuduWebsite {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[String]$notes='',
		[String]$paused='',
		[Parameter(Mandatory=$true)]
		[Int]$companyid='',
		[String]$disabledns='',
		[String]$disablessl='',
		[String]$disablewhois=''
	)
	
	$website = @{website = @{}}
	
	if ($name) {
		$website.website.add('name',$name)
	}
	
	if ($notes) {
		$website.website.add('notes',$notes)
	}
	
	if ($paused) {
		$website.website.add('paused',$paused)
	}
	
	if ($companyid) {
		$website.website.add('company_id',$companyid)
	}
	
	if ($disabledns) {
		$website.website.add('disable_dns',$disabledns)
	}
	
	if ($disablessl) {
		$website.website.add('disable_ssl',$disablessl)
	}
	
	if ($disablewhois) {
		$website.website.add('disable_whois',$disablewhois)
	}
	
	$json = $website | convertto-json
	
	$response = hudu_request -Method post -Resource "/api/v1/websites" -body $json
	
	$response
	
}
	
