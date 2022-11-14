function Get-HuduAssets {
	[CmdletBinding()]
	Param (
		[Int]$Id = '',
		[Alias('asset_layout_id')]
		[Int]$AssetLayoutId = '',
		[Alias('company_id')]
		[Int]$CompanyId = '',
		[String]$Name = '',
		[Bool]$Archived = $false,
		[Alias('primary_serial')]
		[String]$PrimarySerial = ''
	)
	

	if ($id -and $CompanyId) {
		$Asset = Invoke-HuduRequest -Method get -Resource "/api/v1/companies/$CompanyId/assets/$Id"
		return $Asset
	}
 else {

		$ResourceFilter = ''
	
		if ($CompanyId) {
			$ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
		}
	
		if ($AssetLayoutId) {
			$ResourceFilter = "$($ResourceFilter)&asset_layout_id=$($AssetLayoutId)"
		}
	
		if ($Name) {
			$ResourceFilter = "$($ResourceFilter)&name=$($Name)"
		}

		if ($Archived) {
			$ResourceFilter = "$($ResourceFilter)&archived=$($Archived)"
		}

		if ($PrimarySerial) {
			$ResourceFilter = "$($ResourceFilter)&primary_serial=$($PrimarySerial)"
		}

		if ($Id) {
			$ResourceFilter = "$($ResourceFilter)&id=$($Id)"
		}	
	
		$i = 1;
		$AllAssets = do {
			$Assets = Invoke-HuduRequest -Method get -Resource "/api/v1/assets?page=$i&page_size=1000$($ResourceFilter)"
			$i++
			$Assets.Assets
		} while ($Assets.Assets.count % 1000 -eq 0 -and $Assets.Assets.count -ne 0)
		
		return $AllAssets
	}
}
 