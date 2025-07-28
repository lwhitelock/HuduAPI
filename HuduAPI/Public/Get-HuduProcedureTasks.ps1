function Get-HuduProcedureTasks {
    <#
    .SYNOPSIS
    Retrieve procedure tasks

    .DESCRIPTION
    Retrieves either a list of procedure tasks based on filters or a specific task by ID.

    .PARAMETER Id
    Task ID to retrieve

    .PARAMETER ProcedureId
    Filter by procedure ID

    .PARAMETER Name
    Filter by task name

    .PARAMETER CompanyId
    Filter by company ID

    .EXAMPLE
    Get-HuduProcedureTasks -ProcedureId 123

    .EXAMPLE
    Get-HuduProcedureTasks -Id 999
    #>
    [CmdletBinding()]
    param(
        [int]$Id,
        [int]$ProcedureId,
        [string]$Name,
        [int]$CompanyId
    )

    if ($Id) {
        try {
            $res = Invoke-HuduRequest -Method GET -Resource "/api/v1/procedure_tasks/$Id"
            return $res.procedure_task
        } catch {
            Write-Warning "Failed to retrieve procedure task ID $Id"
            return $null
        }
    }

    $params = @{}
    if ($ProcedureId) { $params.procedure_id = $ProcedureId }
    if ($Name)        { $params.name         = $Name }
    if ($CompanyId)   { $params.company_id   = $CompanyId }

    Invoke-HuduRequestPaginated -HuduRequest @{
        Method   = 'GET'
        Resource = '/api/v1/procedure_tasks'
        Params   = $params
    } -Property procedure_tasks
}
