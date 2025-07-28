function Get-HuduProcedures {
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

    .PARAMETER GlobalTemplate
    Filter for global templates (true/false)

    .PARAMETER CompanyTemplate
    Filter for company-specific templates by company ID

    .PARAMETER ParentProcedureId
    Filter for procedures that are children of another procedure

    .EXAMPLE
    Get-HuduProcedures -Id 5

    .EXAMPLE
    Get-HuduProcedures -CompanyId 123 -Name "Onboarding"

    .EXAMPLE
    Get-HuduProcedures -Name 'Procedure 1'

    #>
    [CmdletBinding()]
    Param (
        [Int]$Id = '',
        [Alias('company_id')]
        [Int]$CompanyId = '',
        [String]$Name = '',
        [string]$GlobalTemplate,
        [int]$CompanyTemplate,
        [int]$ParentProcedureId
    )


    if ($Id) {
        try {
            $res = Invoke-HuduRequest -Method GET -Resource "/api/v1/procedures/$Id"
            return $res.procedure
        } catch {
            Write-Warning "Failed to retrieve procedure ID $Id"
            return $null
        }
    }

    $params = @{}
    if ($Name) { $params.name = $Name }
    if ($Slug) { $params.slug = $Slug }
    if ($CompanyId) { $params.company_id = $CompanyId }
    if ($GlobalTemplate) { $params.global_template = $GlobalTemplate }
    if ($CompanyTemplate) { $params.company_template = $CompanyTemplate }
    if ($ParentProcedureId) { $params.parent_procedure_id = $ParentProcedureId }

    Invoke-HuduRequestPaginated -HuduRequest @{
        Method   = 'GET'
        Resource = '/api/v1/procedures'
        Params   = $params
    } -Property procedures
}