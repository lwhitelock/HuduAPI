function Initialize-HuduFolder {
    [CmdletBinding()]
    param(
        [String[]]$FolderPath,
        [Alias('company_id')]
        [Nullable[int]]$CompanyId
    )

    if ($null -ne $CompanyId) {
        $FolderMap = Get-HuduFolderMap -company_id $CompanyId
    } else {
        $FolderMap = Get-HuduFolderMap
    }

    $CurrentFolder = $FolderMap
    foreach ($Folder in $FolderPath) {
        if ($CurrentFolder.$(Get-HuduFolderCleanName $Folder)) {
            $CurrentFolder = $CurrentFolder.$(Get-HuduFolderCleanName $Folder)
        } else {
            $NewFolderParams = @{
                Name = $Folder
            }

            if ($null -ne $CompanyId) {
                $NewFolderParams.CompanyId = $CompanyId
            }

            if ($null -ne $CurrentFolder.id) {
                $NewFolderParams.ParentFolderId = $CurrentFolder.id
            }

            $CurrentFolder = (New-HuduFolder @NewFolderParams).folder
        }
    }

    return $CurrentFolder
}
