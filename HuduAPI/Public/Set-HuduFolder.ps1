function Set-HuduFolder {
    <#
    .SYNOPSIS
    Update a Folder

    .DESCRIPTION
    Uses Hudu API to update a folder

    .PARAMETER Id
    Id of the requested folder

    .PARAMETER Name
    Name of the folder

    .PARAMETER Icon
    Folder icon

    .PARAMETER Description
    Folder description

    .PARAMETER ParentFolderId
    Folder parent id

    .PARAMETER CompanyId
    Folder company id

    .EXAMPLE
    Set-HuduFolder -Id 1 -Name 'New folder name'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,

        [String]$Name,

        [String]$Icon,

        [String]$Description,

        [Alias('parent_folder_id')]
        [Nullable[int]]$ParentFolderId,

        [Alias('company_id')]
        [Nullable[int]]$CompanyId
    )

    $folderObject = get-hudufolders -id $id; $folderobject = $folderobject.folder ?? $folderobject

    $Folder = [ordered]@{folder = [ordered]@{} }

    if ($PSBoundParameters.ContainsKey('Name')) {
        $Folder.folder.add('name', $Name)
    } else {
        $Folder.folder.add('name', $folderObject.name)
    }

    if ($PSBoundParameters.ContainsKey('Icon')) {
        $Folder.folder.add('icon', $Icon)
    } else {
        $Folder.folder.add('icon', $folderObject.icon)
    }

    if ($PSBoundParameters.ContainsKey('Description')) {
        $Folder.folder.add('description', $Description)
    } else {
        $Folder.folder.add('description', $folderObject.description)
    }

    if ($PSBoundParameters.ContainsKey('ParentFolderId')) {
        $Folder.folder.add('parent_folder_id', $ParentFolderId)
    } else {
        $Folder.folder.add('parent_folder_id', $folderObject.parent_folder_id)
    }

    if ($PSBoundParameters.ContainsKey('CompanyId')) {
        $Folder.folder.add('company_id', $CompanyId)
    } else {
        $Folder.folder.add('company_id', $folderObject.company_id)
    }

    $JSON = $Folder | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/folders/$Id" -Body $JSON
    }
}
