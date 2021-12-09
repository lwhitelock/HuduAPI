function Set-HuduAssetLayout {
	[CmdletBinding()]
	# This will silence the warning for variables with Password in their name.
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "")]
	Param (
		[Parameter(Mandatory = $true)]
		[Int]$Id,
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Parameter(Mandatory = $true)]
		[String]$Icon,
		[Parameter(Mandatory = $true)]
		[String]$Color,
		[Alias("icon_color")]
		[Parameter(Mandatory = $true)]
		[String]$IconColor,
		[Alias("include_passwords")]
		[bool]$IncludePasswords = '',
		[Alias("include_photos")]
		[bool]$IncludePhotos = '',
		[Alias("include_comments")]
		[bool]$IncludeComments = '',
		[Alias("include_files")]
		[bool]$IncludeFiles = '',
		[Alias("password_types")]
		[String]$PasswordTypes = '',
		[Parameter(Mandatory = $true)]
		[array]$Fields,
		[bool]$Active = $true
	)
	
	foreach ($Field in $Fields) {
		$Field.show_in_list = [System.Convert]::ToBoolean($Field.show_in_list)
		$Field.required = [System.Convert]::ToBoolean($Field.required)
		$Field.expiration = [System.Convert]::ToBoolean($Field.expiration)
	}


	$AssetLayout = [ordered]@{asset_layout = [ordered]@{} }
	
	$AssetLayout.asset_layout.add('name', $Name)
	$AssetLayout.asset_layout.add('icon', $Icon)
	$AssetLayout.asset_layout.add('color', $Color)
	$AssetLayout.asset_layout.add('icon_color', $IconColor)
	$AssetLayout.asset_layout.add('fields', $Fields)
	$AssetLayout.asset_layout.add('active', $Active)
		
	if ($IncludePasswords) {
		$AssetLayout.asset_layout.add('include_passwords', [System.Convert]::ToBoolean($IncludePasswords))
	}
	
	if ($IncludePhotos) {
		$AssetLayout.asset_layout.add('include_photos', [System.Convert]::ToBoolean($IncludePhotos))
	}
	
	if ($IncludeComments) {
		$AssetLayout.asset_layout.add('include_comments', [System.Convert]::ToBoolean($IncludeComments))
	}
	
	if ($IncludeFiles) {
		$AssetLayout.asset_layout.add('include_files', [System.Convert]::ToBoolean($IncludeFiles))
	}
	
	if ($PasswordTypes) {
		$AssetLayout.asset_layout.add('password_types', $PasswordTypes)
	}
	
	
	$JSON = $AssetLayout | convertto-json -Depth 10
	
	$Response = Invoke-HuduRequest -Method put -Resource "/api/v1/asset_layouts/$Id" -body $JSON
	
	$Response
}