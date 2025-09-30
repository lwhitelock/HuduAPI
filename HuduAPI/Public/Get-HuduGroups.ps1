function Get-HuduGroups {
    <#
    .SYNOPSIS
    Retrieve Hudu groups.

    .DESCRIPTION
    Calls the Hudu API to return groups.  
    You can fetch a single group by Id, or filter/search across all groups.

    .PARAMETER Id
    The numeric ID of the group to retrieve.

    .PARAMETER Name
    Name of the group (for filtering).

    .PARAMETER Search
    Search string to filter groups by.

    .PARAMETER Default
    Boolean flag to return only default groups.

    .EXAMPLE
    Get-HuduGroups
    Retrieves all groups.

    .EXAMPLE
    Get-HuduGroups -Id 123
    Retrieves the group with ID 123.

    .EXAMPLE
    Get-HuduGroups -Search "Technicians"
    Returns all groups matching the word "Technicians".
    #>
    [CmdletBinding()]
    Param (
        [Int]$Id,
        [String]$Name,
        [String]$Search,
        [bool]$Default
    )

    if ($id) {
        return $(Invoke-HuduRequest -Method get -Resource "/api/v1/groups/$id").group
    } else {
        $Params = @{}

        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($Search) { $Params.search = $Search }
        if ($Default) { $Params.default = $Default }

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/groups'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -property groups
    }
}
