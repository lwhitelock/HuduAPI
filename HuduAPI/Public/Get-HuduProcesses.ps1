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
    Get-HuduProcesses -Name 'Procedure 1'

    #>
    [CmdletBinding()]
    Param (
        [Parameter(ParameterSetName = 'Single')]
        [Int]$Id = '',

        [Parameter(ParameterSetName = 'List')]
        [Alias('company_id')]
        [Int]$CompanyId = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$Name = '',

        [Parameter(ParameterSetName = 'List')]
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

Set-Alias -Name Get-HuduProcedures -Value Get-HuduProcesses
