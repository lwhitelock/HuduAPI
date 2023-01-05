function Get-HuduCard {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[Alias("integration_slug")]
		[String]$IntegrationSlug,
		[Alias("integration_id")]
		[String]$IntegrationId = '',
		[Alias("integration_identifier")]
		[String]$IntegrationIdentifier = ''
	
	)
	
	
	$ResourceFilter = "&integration_slug=$($IntegrationSlug)"

	if ($IntegrationId) {
		$ResourceFilter = "$($ResourceFilter)&integration_id=$($IntegrationId)"
	}

	if ($IntegrationIdentifier) {
		$ResourceFilter = "$($ResourceFilter)&integration_identifier=$($IntegrationIdentifier)"
	}

	$i = 1;
	$AllCards = do {
		$Cards = Invoke-HuduRequest -Method get -Resource "/api/v1/cards/lookup?page=$i&page_size=1000$($ResourceFilter)"
		$i++
		$Cards.integrator_cards
	} while ($Cards.integrator_cards.count % 1000 -eq 0 -and $Cards.integrator_cards.count -ne 0)
	

	return $AllCards
	
}