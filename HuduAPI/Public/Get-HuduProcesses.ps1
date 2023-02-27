function Get-HuduProcesses {
    <#
    .SYNOPSIS
    Get a list of Procedures (Processes)

    .DESCRIPTION
    Calls Hudu API to retrieve list of procedures

    .PARAMETER Id
    Id of the Procedure

    .PARAMETER CompanyId
    Filter by company id

    .PARAMETER Name
    Fitler by name of article

    .PARAMETER Slug
    Filter by url slug

    .EXAMPLE
    Get-HuduProcedures -Name 'Procedure 1'

    #>
    [CmdletBinding()]
    Param (
        [Int]$Id = '',
        [Alias('company_id')]
        [Int]$CompanyId = '',
        [String]$Name = '',
        [String]$Slug
    )

    if ($Id) {
        Invoke-HuduRequest -Method get -Resource "/api/v1/procedures/$id"
    } else {
        $Params = @{}

        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($Name) { $Params.name = $Name }
        if ($Slug) { $Params.slug = $Slug }


        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/procedures'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'procedures'
    }
}