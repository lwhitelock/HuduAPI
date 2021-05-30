function Get-HuduFolderMap {
	Param (
		[Int]$company_id = ''
	)
	
	if ($company_id) {
		$FoldersRaw = Get-HuduFolders -company_id $company_id
		$SubFolders = Get-HuduCompanyFolders -FoldersRaw $FoldersRaw

	}
 else {
		$FoldersRaw = Get-HuduFolders
		$FoldersProcessed = $FoldersRaw | where-Object {$null -eq $_.company_id}
		$SubFolders = Get-HuduCompanyFolders -FoldersRaw $FoldersProcessed
	}

	return $SubFolders
}