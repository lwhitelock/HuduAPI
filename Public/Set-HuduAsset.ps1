function Set-HuduAsset {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Alias("company_id")]
		[Parameter(Mandatory=$true)]
		[Int]$companyId='',
		[Alias("asset_layout_id")]
		[Parameter(Mandatory=$true)]
		[Int]$assetLayoutId='',
		[Parameter(Mandatory=$true)]
		[Array]$fields='',
		[Alias("asset_id")]
		[Parameter(Mandatory=$true)]
		[Int]$assetId=''
		
	)
	

	$asset = [ordered]@{asset = [ordered]@{}}
	
	$asset.asset.add('name',$name)
	$asset.asset.add('asset_layout_id',$asset_layout_id)
	$asset.asset.add('custom_fields',$fields)
	
	$json = $asset | convertto-json -Depth 10
	
	$response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$company_id/assets/$asset_id" -body $json
	
	$response
	
	
}
