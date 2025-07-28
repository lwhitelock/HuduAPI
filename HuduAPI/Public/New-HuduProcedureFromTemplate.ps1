function New-HuduProcedureFromTemplate {
    <#
    .SYNOPSIS
    Create a new procedure from an existing template

    .DESCRIPTION
    Creates a new procedure (template or process) by cloning an existing one.
    If no company_id is provided, a global template is created.

    .PARAMETER Id
    ID of the template procedure to clone

    .PARAMETER CompanyId
    Optional company ID. If omitted, creates a global template.

    .PARAMETER Name
    Optional new name for the new procedure

    .PARAMETER Description
    Optional description for the new procedure

    .EXAMPLE
    New-HuduProcedureFromTemplate -Id 50 -CompanyId 456 -Name "Client Onboarding Clone"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [int]$CompanyId,
        [string]$Name,
        [string]$Description
    )

    $params = @{}
    if ($CompanyId)   { $params.company_id = $CompanyId }
    if ($Name)        { $params.name = $Name }
    if ($Description) { $params.description = $Description }

    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/procedures/$Id/create_from_template" -Params $params
        return $res.procedure
    } catch {
        Write-Warning "Failed to create procedure from template ID $Id"
        return $null
    }
}
