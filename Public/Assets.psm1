function Get-HuduAssets {
	Param (
		[Int]$id = '',
		[Int]$assetlayoutid = '',
		[Int]$companyid = '',
		[String]$name =''
	
	)
	
	#
	$i = 1;
		$AllAssets = do {
		$Assets = hudu_request -Method get -Resource "/api/v1/assets?page=$i&page_size=1000"
		$i++
		$Assets.Assets
		} while ($Assets.Assets.count % 1000 -eq 0 -and $Assets.Assets.count -ne 0)
		
		
	if ($id) {
	$AllAssets = $AllAssets | where-object {$_.id -eq $id}
	}
		
	if ($name) {
	$AllAssets = $AllAssets | where-object {$_.name -eq $name}
	}
	
	if ($assetlayoutid) {
	$AllAssets = $AllAssets | where-object {$_.asset_layout_id -eq $assetlayoutid}
	}
	
	if ($companyid) {
	$AllAssets = $AllAssets | where-object {$_.company_id -eq $companyid}
	}
	
	
	return $AllAssets
	
}

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
	

	$asset = @{asset = @{}}
	
	$asset.asset.add('name',$name)
	$asset.asset.add('asset_layout_id',$asset_layout_id)
	$asset.asset.add('fields',$fields)
	
	$json = $asset | convertto-json -Depth 10
	
	$response = hudu_request -Method post -Resource "/api/v1/companies/$company_id/assets" -body $json
	
	$response
	
	
}
		
function Set-HuduAsset {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[Int]$company_id='',
		[Parameter(Mandatory=$true)]
		[Int]$asset_layout_id='',
		[Parameter(Mandatory=$true)]
		[Array]$fields='',
		[Parameter(Mandatory=$true)]
		[Int]$asset_id=''
		
	)
	

	$asset = @{asset = @{}}
	
	$asset.asset.add('name',$name)
	$asset.asset.add('asset_layout_id',$asset_layout_id)
	$asset.asset.add('fields',$fields)
	
	$json = $asset | convertto-json -Depth 10
	
	$response = hudu_request -Method put -Resource "/api/v1/companies/$company_id/assets/$asset_id" -body $json
	
	$response
	
	
}