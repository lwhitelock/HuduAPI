function Get-HuduFolderMap {
	[CmdletBinding()]
	Param (
		[Alias("company_id")]
		[Int]$CompanyId = ''
	)
	
	if ($CompanyId) {
		$FoldersRaw = Get-HuduFolders -company_id $CompanyId
		$SubFolders = Get-HuduCompanyFolders -FoldersRaw $FoldersRaw

	} else {
		$FoldersRaw = Get-HuduFolders
		$FoldersProcessed = $FoldersRaw | where-Object { $null -eq $_.company_id }
		$SubFolders = Get-HuduCompanyFolders -FoldersRaw $FoldersProcessed
	}

	return $SubFolders
}