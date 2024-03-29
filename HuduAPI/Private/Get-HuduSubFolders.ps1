function Get-HuduSubFolders {
    [CmdletBinding()]
    Param(
        [int]$id,
        [PSCustomObject]$FoldersRaw
    )

    $SubFolders = $FoldersRaw | Where-Object { $_.parent_folder_id -eq $id }
    $ReturnFolders = [System.Collections.ArrayList]@()
    foreach ($Folder in $SubFolders) {
        $SubSubFolders = Get-HuduSubFolders -id $Folder.id -FoldersRaw $FoldersRaw
        foreach ($AddFolder in $SubSubFolders) {
            $null = $folder | Add-Member -MemberType NoteProperty -Name $(Get-HuduFolderCleanName $($AddFolder.PSObject.Properties.name)) -Value $AddFolder.PSObject.Properties.value
        }
        $ReturnObject = [PSCustomObject]@{
            $(Get-HuduFolderCleanName $($Folder.name)) = $Folder
        }
        $null = $ReturnFolders.add($ReturnObject)
    }

    return $ReturnFolders

}