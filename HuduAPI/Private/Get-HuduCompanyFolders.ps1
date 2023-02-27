function Get-HuduCompanyFolders {
    [CmdletBinding()]
    Param (
        [PSCustomObject]$FoldersRaw
    )

    $RootFolders = $FoldersRaw | Where-Object { $null -eq $_.parent_folder_id }
    $ReturnObject = [PSCustomObject]@{}
    foreach ($folder in $RootFolders) {
        $SubFolders = Get-HuduSubFolders -id $folder.id -FoldersRaw $FoldersRaw
        foreach ($SubFolder in $SubFolders) {
            $Folder | Add-Member -MemberType NoteProperty -Name $(Get-HuduFolderCleanName $($SubFolder.PSObject.Properties.name)) -Value $SubFolder.PSObject.Properties.value
        }
        $ReturnObject | Add-Member -MemberType NoteProperty -Name $(Get-HuduFolderCleanName $($folder.name)) -Value $folder
    }
    return $ReturnObject
}