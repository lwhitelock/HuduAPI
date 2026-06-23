function Get-HuduFolders {
    <#
    .SYNOPSIS
    Get a list of Folders

    .DESCRIPTION
    Calls Hudu API to retrieve folders

    .PARAMETER Id
    Id of the folder

    .PARAMETER Name
    Filter by name

    .PARAMETER CompanyId
    Filter by company_id

    .PARAMETER folderType
    Filter by folder_type. Accepts "article" or "photo", default is "article"

    .EXAMPLE
    Get-HuduFolders

    #>
    [CmdletBinding()]
    Param (
        [Nullable[int]]$Id,
        [String]$Name,
        [Alias('company_id')]
        [Nullable[int]]$CompanyId,
        [ValidateSet("article","photo", ignoreCase = $true)]
        [Alias('folder_type')]
        [string]$folderType="article"
    )

    if ($PSBoundParameters.ContainsKey('id')) {
        $Folder = Invoke-HuduRequest -Method get -Resource "/api/v1/folders/$id"
        return $Folder.Folder
    } else {
        $Params = @{}

        if ($PSBoundParameters.ContainsKey('CompanyId')) { $Params.company_id = $CompanyId }
        if ($PSBoundParameters.ContainsKey('Name')) { $Params.name = $Name }
        $Params.folder_type = "$folderType".ToLower()

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/folders'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property folders
    }
}