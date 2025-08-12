function Set-HuduProcedure {
    <#
    .SYNOPSIS
    Update an existing Hudu procedure

    .DESCRIPTION
    Updates fields of an existing procedure by ID.

    .PARAMETER Id
    ID of the procedure to update

    .PARAMETER Name
    New name for the procedure

    .PARAMETER Description
    New description

    .PARAMETER CompanyTemplate
    Whether this procedure should be marked as a company template

    .PARAMETER CompanyId
    The company ID the procedure belongs to

    .PARAMETER Archived
    Whether this procedure should be archived

    .EXAMPLE
    Set-HuduProcedure -Id 10 -Name "Updated Name" -Archived $true
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [string]$Name,
        [string]$Description,
        [bool]$CompanyTemplate,
        [int]$CompanyId,
        [bool]$Archived
    )

    $payload = @{
        name             = $Name
        description      = $Description
        company_template = $CompanyTemplate
        company_id       = $CompanyId
        archived         = $Archived
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method PUT -Resource "/api/v1/procedures/$Id" -Body $payload
        return $res.procedure
    } catch {
        Write-Warning "Failed to update procedure ID $Id"
        return $null
    }
}
