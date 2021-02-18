function Get-HuduAssets {
	Param (
		[Int]$id = '',
		[Int]$assetlayoutid = '',
		[Int]$companyid = '',
		[String]$name =''
	
	)
	
	#
	$i = 0;
		$AllAssets = do {
		$Assets = hudu_request -Method get -Resource "/api/v1/assets?page=$i&page_size=1000"
		$i++
		$Assets.Assets
		Write-Host "Retrieved $($Assets.Assets.count) Assets" -ForegroundColor Yellow
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
		
