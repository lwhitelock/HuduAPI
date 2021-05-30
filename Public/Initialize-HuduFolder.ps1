function Initialize-HuduFolder {
    param(
        [String[]]$FolderPath,
        [int]$Company_ID
    )

    if ($company_id) {
        $FolderMap = Get-HuduFolderMap -company_id $Company_ID
    } else {
        $FolderMap = Get-HuduFolderMap
    }

    $CurrentFolder = $Foldermap
    foreach ($Folder in $FolderPath) {
        if ($CurrentFolder.$(Get-HuduFolderCleanName $Folder)){
            $CurrentFolder = $CurrentFolder.$(Get-HuduFolderCleanName $Folder)
        } else {
            $CurrentFolder = (New-HuduFolder -name $Folder -company_id $Company_ID -parent_folder_id $CurrentFolder.id).folder
        }
    }

    Return $CurrentFolder
}