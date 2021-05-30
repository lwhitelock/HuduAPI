function Get-HuduFolders {
	Param (
		[Int]$id = '',
		[Int]$name = '',
		[Int]$company_id = ''
	)
	
	if ($id) {
		$Folder = Invoke-HuduRequest -Method get -Resource "api/v1/folders/$id"
		return $Folder
	} else {

		$resourcefilter = ''
	
		if ($company_id) {
			$resourcefilter = "$($resourcefilter)&company_id=$($company_id)"
		}
	
		if ($name) {
			$resourcefilter = "$($resourcefilter)&name=$($name)"
		}
	
		$i = 1;
		$AllFolders = do {
			$Folders = Invoke-HuduRequest -Method get -Resource "/api/v1/folders?page=$i&page_size=1000$($resourcefilter)"
			$i++
			$Folders.Folders
		} while ($Folders.Folders.count % 1000 -eq 0 -and $Folders.Folders.count -ne 0)
		
		
	
		return $AllFolders

	}
}