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

        [Parameter(Mandatory = $true)]
        [String]$Name,

        [String]$Icon = '',

        [String]$Description = '',

        [Alias('parent_folder_id')]
        [Int]$ParentFolderId = '',

        [Alias('company_id')]
        [Int]$CompanyId = ''
    )

    $Folder = [ordered]@{folder = [ordered]@{} }

    $Folder.folder.add('name', $Name)

    if ($icon) {
        $Folder.folder.add('icon', $Icon)
    }

    if ($Description) {
        $Folder.folder.add('description', $Description)
    }

    if ($ParentFolderId) {
        $Folder.folder.add('parent_folder_id', $ParentFolderId)
    }

    if ($CompanyId) {
        $Folder.folder.add('company_id', $CompanyId)
    }

    $JSON = $Folder | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/folders/$Id" -Body $JSON
    }
}
