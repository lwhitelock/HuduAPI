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

    .EXAMPLE
    Get-HuduFolders

    #>
    [CmdletBinding()]
    Param (
        [Int]$Id = '',
        [String]$Name = '',
        [Alias('company_id')]
        [Int]$CompanyId = ''
    )

    if ($id) {
        $Folder = Invoke-HuduRequest -Method get -Resource "/api/v1/folders/$id"
        return $Folder.Folder
    } else {
        $Params = @{}

        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($Name) { $Params.name = $Name }

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/folders'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property folders
    }
}
