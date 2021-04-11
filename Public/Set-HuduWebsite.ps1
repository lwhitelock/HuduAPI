function Set-HuduWebsite {
	Param (
        [Parameter(Mandatory=$true)]
		[Int]$id ='',
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
	
	$website = [ordered]@{website = [ordered]@{}}
	
	$website.website.add('name',$name)
		
	if ($notes) {
		$website.website.add('notes',$notes)
	}
	
	if ($paused) {
		$website.website.add('paused',$paused)
	}
	
	$website.website.add('company_id',$companyid)
	
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
	
	$response = Invoke-HuduRequest -Method put -Resource "/api/v1/websites/$id" -body $json
	
	$response
	
}