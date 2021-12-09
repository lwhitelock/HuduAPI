function New-HuduFolder {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[String]$Icon = '',
		[String]$Description = '',
		[Alias("parent_folder_id")]
		[Int]$ParentFolderId = '',
		[Alias("company_id")]
		[Int]$CompanyId = ''
	)
	
	$Folder = [ordered]@{folder = [ordered]@{} }
	
	$Folder.folder.add('name', $Name)
		
	if ($Icon) {
		$Folder.folder.add('icon', $Icon)
	}
	
	if ($Description) {
		$Folder.folder.add('description', $Description)
	}
	
	if ($ParentFolderId) {
		$Folder.folder.add('parent_folder_id', $ParentFolderId)
	}
	
	if ($CompanyId) {
		$Folder.folder.add('company_id', $CompanyId)
	}
		
	$JSON = $Folder | convertto-json
	
	$Response = Invoke-HuduRequest -Method post -Resource "/api/v1/folders" -body $JSON
	
	$Response
	
}