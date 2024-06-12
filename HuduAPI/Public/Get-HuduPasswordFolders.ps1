function Get-HuduPasswordFolders {
    <#
    .SYNOPSIS
    Get a list of Password Folders

    .DESCRIPTION
    Calls Hudu API to retrieve folders

    .PARAMETER Id
    Id of the folder

    .PARAMETER Name
    Filter by name

    .PARAMETER CompanyId
    Filter by company_id

    .EXAMPLE
    Get-HuduFolders

    #>
    [CmdletBinding()]
    Param (
        [Int]$Id = '',
        [String]$Name = '',
        [String]$Search = '',
        [Alias('company_id')]
        [Int]$CompanyId = '',
        [Int]$page = '',
        [Int]$page_size = ''
    )

    if ($id) {
        $Folder = Invoke-HuduRequest -Method get -Resource "/api/v1/password_folders/$id"
        return $Folder.password_folder
    } else {
        $Params = @{}

        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($Name) { $Params.name = $Name }

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/password_folders'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property password_folders
    }
}
