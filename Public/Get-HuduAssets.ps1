function Get-HuduAssets {
	Param (
		[Int]$id = '',
		[Int]$assetlayoutid = '',
		[Int]$companyid = '',
		[String]$name ='',
		[Bool]$archived = $false,
		[String]$primary_serial =''
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
	
		if ($name) {
			$resourcefilter = "$($resourcefilter)&name=$($name)"
		}

		if ($archived) {
			$resourcefilter = "$($resourcefilter)&archived=$($archived)"
		}

		if ($primary_serial) {
			$resourcefilter = "$($resourcefilter)&primary_serial=$($primary_serial)"
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
	
		return $AllAssets

	}
}