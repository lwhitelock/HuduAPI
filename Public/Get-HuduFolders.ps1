function Get-HuduFolders {
	[CmdletBinding()]
	Param (
		[Int]$Id = '',
		[Int]$Name = '',
		[Alias("company_id")]
		[Int]$CompanyId = ''
	)
	
	if ($id) {
		$Folder = Invoke-HuduRequest -Method get -Resource "/api/v1/folders/$id"
		return $Folder.Folder
	} else {

		$ResourceFilter = ''
	
		if ($CompanyId) {
			$resourcefilter = "$($ResourceFilter)&company_id=$($CompanyId)"
		}
	
		if ($Name) {
			$ResourceFilter = "$($ResourceFilter)&name=$($Name)"
		}
	
		$i = 1;
		$AllFolders = do {
			$Folders = Invoke-HuduRequest -Method get -Resource "/api/v1/folders?page=$i&page_size=1000$($ResourceFilter)"
			$i++
			$Folders.Folders
		} while ($Folders.Folders.count % 1000 -eq 0 -and $Folders.Folders.count -ne 0)
		
		
	
		return $AllFolders

	}
}