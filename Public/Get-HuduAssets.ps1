function Get-HuduAssets {
	Param (
		[Int]$id = '',
		[Int]$assetlayoutid = '',
		[Int]$companyid = '',
		[String]$name =''
	
	)
	
	if ($id -and $companyid) {
		$Asset = Invoke-HuduRequest -Method get -Resource "api/v1/companies/$companyid/assets/$id"
		return $Asset
	} else {

	$resourcefilter = ''
	
	if ($companyid) {
		$resourcefilter = "$($resourcefilter)&company_id=$($companyid)"
	}
	
	if ($assetlayoutid) {
		$resourcefilter = "$($resourcefilter)&asset_layout_id=$($assetlayoutid)"
	}
	
	
	$i = 1;
	$AllAssets = do {
		$Assets = Invoke-HuduRequest -Method get -Resource "/api/v1/assets?page=$i&page_size=1000$($resourcefilter)"
		$i++
		$Assets.Assets
		} while ($Assets.Assets.count % 1000 -eq 0 -and $Assets.Assets.count -ne 0)
		
		
	if ($id) {
	$AllAssets = $AllAssets | where-object {$_.id -eq $id}
	}
		
	if ($name) {
	$AllAssets = $AllAssets | where-object {$_.name -eq $name}
	}
		
	
	return $AllAssets

}
}