function Get-HuduAssetLayouts {
	[CmdletBinding()]
	Param (
		[String]$Name,
		[Alias("id", "layout_id")]
		[String]$LayoutId
	)
	
	if ($LayoutId) {
		$AssetLayout = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_layouts/$($LayoutId)"
		return $AssetLayout.asset_layout
	} else {

		$ResourceFilter = ''

		if ($Name) {
			$ResourceFilter = "$($ResourceFilter)&name=$($Name)"
		}
		
		$i = 1;
		$AllAssetLayouts = do {
			$AssetLayouts = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_layouts?page=$i&page_size=25$($ResourceFilter)"
			$i++
			$AssetLayouts.Asset_Layouts
		} while ($AssetLayouts.asset_layouts.count % 25 -eq 0 -and $AssetLayouts.asset_layouts.count -ne 0)
		
		return $AllAssetLayouts
	}
}