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
	

	$asset_layout = [ordered]@{asset_layout = [ordered]@{}}
	
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
	
	$response = Invoke-HuduRequest -Method post -Resource "/api/v1/asset_layouts" -body $json
	
	$response
	
	
	
	
}