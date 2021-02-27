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