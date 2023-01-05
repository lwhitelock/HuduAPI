function New-HuduRelation {
	[CmdletBinding()]
	Param (
		[String]$Description,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Asset','Website','Procedure','AssetPassword','Company','Article')]
		[Alias("fromable_type")]
		[String]$FromableType,
		[Alias("fromable_id")]
		[int]$FromableID,
		[Alias("toable_type")]
		[String]$ToableType,
		[Alias("toable_id")]
		[int]$ToableID,
		[Alias("is_inverse")]
		[string]$ISInverse
	)
	

	$Relation = [ordered]@{relation = [ordered]@{} }
	
	$Relation.relation.add('fromable_type', $FromableType)
	$Relation.relation.add('fromable_id', $FromableID)
	$Relation.relation.add('toable_type', $ToableType)
	$Relation.relation.add('toable_id', $ToableID)
	
	if ($Description) {
		$Relation.relation.add('description', $Description)
	}
	
	if ($ISInverse) {
		$Relation.relation.add('is_inverse', $ISInverse)
	}
	
	$JSON = $Relation | convertto-json -Depth 100
	
	$Response = Invoke-HuduRequest -Method post -Resource "/api/v1/relations" -body $JSON
	
	$Response
	
}