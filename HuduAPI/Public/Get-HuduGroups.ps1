function Get-HuduGroups {
    <#
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
