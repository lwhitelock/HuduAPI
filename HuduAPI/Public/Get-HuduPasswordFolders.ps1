function Get-HuduPasswordFolders {
    <#
    .SYNOPSIS
    Retrieve password folders.

    .DESCRIPTION
    Calls the Hudu API to return password folders.  
    You can fetch a single folder by Id, or filter by name/company.

    .PARAMETER Id
    The numeric ID of the folder to retrieve.

    .PARAMETER Name
    Filter by folder name.

    .PARAMETER CompanyId
    Filter by company ID.

    .EXAMPLE
    Get-HuduPasswordFolders
    Retrieves all password folders.

    .EXAMPLE
    Get-HuduPasswordFolders -Id 12
    Retrieves the folder with ID 12.

    .EXAMPLE
    Get-HuduPasswordFolders -CompanyId 5
    Retrieves folders belonging to company with ID 5.
    #>
    [CmdletBinding()]
    Param (
        [Int]$Id,
        [String]$Name,
        [String]$Search,
        [Alias('company_id')]
        [Int]$CompanyId
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
