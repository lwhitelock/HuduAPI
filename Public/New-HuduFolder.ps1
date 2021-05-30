function New-HuduFolder {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name,
		[String]$icon='',
		[String]$description='',
		[Int]$parent_folder_id='',
		[Int]$company_id=''
	)
	
	$folder = [ordered]@{folder = [ordered]@{}}
	
	$folder.folder.add('name',$name)
		
	if ($icon) {
		$folder.folder.add('icon',$icon)
	}
	
	if ($description) {
		$folder.folder.add('description',$description)
	}
	
	if ($parent_folder_id) {
		$folder.folder.add('parent_folder_id',$parent_folder_id)
	}
	
	if ($company_id) {
		$folder.folder.add('company_id',$company_id)
	}
		
	$json = $folder | convertto-json
	
	$response = Invoke-HuduRequest -Method post -Resource "/api/v1/folders" -body $json
	
	$response
	
}