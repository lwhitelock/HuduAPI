function New-HuduAsset {
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Alias("company_id")]
		[Parameter(Mandatory = $true)]
		[Int]$CompanyId,
		[Alias("asset_layout_id")]
		[Parameter(Mandatory = $true)]
		[Int]$AssetLayoutId,
		[Parameter(Mandatory = $true)]
		[Array]$Fields
	)
	
	$Asset = [ordered]@{asset = [ordered]@{} }
	
	$Asset.asset.add('name', $Name)
	$Asset.asset.add('asset_layout_id', $AssetLayoutId)
	$Asset.asset.add('custom_fields', $Fields)
	
	$JSON = $Asset | convertto-json -Depth 10
	
	$Response = Invoke-HuduRequest -Method post -Resource "/api/v1/companies/$CompanyId/assets" -body $JSON
	
	$Response
}