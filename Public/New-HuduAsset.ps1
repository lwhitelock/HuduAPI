function New-HuduAsset {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[Int]$company_id='',
		[Parameter(Mandatory=$true)]
		[Int]$asset_layout_id='',
		[Parameter(Mandatory=$true)]
		[Array]$fields=''
	)
	

	$asset = [ordered]@{asset = [ordered]@{}}
	
	$asset.asset.add('name',$name)
	$asset.asset.add('asset_layout_id',$asset_layout_id)
	$asset.asset.add('custom_fields',$fields)
	
	$json = $asset | convertto-json -Depth 10
	
	$response = Invoke-HuduRequest -Method post -Resource "/api/v1/companies/$company_id/assets" -body $json
	
	$response
	
	
}