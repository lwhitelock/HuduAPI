function Get-HuduAssetLayouts {
	Param (
		[String]$name ='',
		[String]$layoutid=''
	)
	
	if ($layoutid) {
		$AssetLayout = hudu_request -Method get -Resource "/api/v1/asset_layouts/$($layoutid)"
		return $AssetLayout.asset_layout
	} else {
		
		$i = 1;
		$AllAssetLayouts = do {
		$AssetLayouts = hudu_request -Method get -Resource "/api/v1/asset_layouts?page=$i&page_size=1000"
		$i++
		$AssetLayouts.Asset_Layouts
		} while ($AssetLayouts.asset_layouts.count % 1000 -eq 0 -and $AssetLayouts.asset_layouts.count -ne 0)
		
		
		if ($name) {
		$AllAssetLayouts = $AllAssetLayouts | where-object {$_.name -eq $name}
		}
		
		return $AllAssetLayouts
	}
}
		

function New-HuduAssetLayout {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[String]$icon='',
		[Parameter(Mandatory=$true)]
		[String]$color='',
		[Parameter(Mandatory=$true)]
		[String]$icon_color='',
		[bool]$include_passwords='',
		[bool]$include_photos='',
		[bool]$include_comments='',
		[bool]$include_files='',
		[String]$password_types='',
		[Parameter(Mandatory=$true)]
		[array]$fields='',
		[bool]$active=$true
	)
	

	$asset_layout = @{asset_layout = @{}}
	
	$asset_layout.asset_layout.add('name',$name)
	$asset_layout.asset_layout.add('icon',$icon)
	$asset_layout.asset_layout.add('color',$color)
	$asset_layout.asset_layout.add('icon_color',$icon_color)
	$asset_layout.asset_layout.add('fields',$fields)
	$asset_layout.asset_layout.add('active',$active)
		
	if ($include_passwords) {
		$asset_layout.asset_layout.add('include_passwords',$include_passwords)
	}
	
	if ($include_photos) {
		$asset_layout.asset_layout.add('include_photos',$include_photos)
	}
	
	if ($include_comments) {
		$asset_layout.asset_layout.add('include_comments',$include_comments)
	}
	
	if ($include_files) {
		$asset_layout.asset_layout.add('include_files',$include_files)
	}
	
	if ($password_types) {
		$asset_layout.asset_layout.add('password_types',$password_types)
	}
	
	
	$json = $asset_layout | convertto-json -Depth 10
	
	$response = hudu_request -Method post -Resource "/api/v1/asset_layouts" -body $json
	
	$response
	
	
	
	
}

function Get-HuduAssetLayoutFieldID {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[Int]$asset_layout_id=''
	)
	
	$layout = Get-HuduAssetLayouts -layoutid $asset_layout_id
	
	$fields = [Collections.Generic.List[Object]]($layout.fields)
	$index = $fields.FindIndex( {$args[0].label -eq $name} )
	$fields[$index].id
	
	
}
	
	
	