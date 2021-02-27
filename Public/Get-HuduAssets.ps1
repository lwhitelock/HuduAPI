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
		$Assets = Invoke-HuduRequest -Method get -Resource "/api/v1/assets?page=$i&page_size=1000"
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