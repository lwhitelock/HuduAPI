function Initialize-HuduFolder {
    [CmdletBinding()]
    param(
        [String[]]$FolderPath,
        [Alias("company_id")]
        [int]$CompanyId
    )

    if ($CompanyId) {
        $FolderMap = Get-HuduFolderMap -company_id $CompanyId
    } else {
        $FolderMap = Get-HuduFolderMap
    }

    $CurrentFolder = $Foldermap
    foreach ($Folder in $FolderPath) {
        if ($CurrentFolder.$(Get-HuduFolderCleanName $Folder)) {
            $CurrentFolder = $CurrentFolder.$(Get-HuduFolderCleanName $Folder)
        } else {
            $CurrentFolder = (New-HuduFolder -name $Folder -company_id $CompanyID -parent_folder_id $CurrentFolder.id).folder
        }
    }

    Return $CurrentFolder
}