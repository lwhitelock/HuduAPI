function New-HuduFolder {
    <#
    .SYNOPSIS
    Create a Folder

    .DESCRIPTION
    Uses Hudu API to create a new folder

    .PARAMETER Name
    Name of the folder

    .PARAMETER Icon
    Folder Icon

    .PARAMETER Description
    Folder description

    .PARAMETER ParentFolderId
    Parent folder ID

    .PARAMETER CompanyId
    Company id

    .EXAMPLE
    New-HuduFolder -Name 'Test folder' -CompanyId 1

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [String]$Icon = '',
        [String]$Description = '',
        [Alias('parent_folder_id')]
        [Int]$ParentFolderId = '',
        [Alias('company_id')]
        [Int]$CompanyId = '',
        [string]$folderType='article'
    )

    $Folder = [ordered]@{folder = [ordered]@{} }

    $Folder.folder.add('name', $Name)

    if ($Icon) {
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

    if ($FolderType) {
        $Folder.folder.add('folder_type', $FolderType)
    }

    $JSON = $Folder | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method post -Resource '/api/v1/folders' -Body $JSON
    }
}
