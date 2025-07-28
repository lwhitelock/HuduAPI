function Copy-HuduProcedure {
    <#
    .SYNOPSIS
    Duplicate an existing procedure

    .DESCRIPTION
    Duplicates a procedure and optionally renames or re-describes it.

    .PARAMETER Id
    ID of the source procedure to duplicate

    .PARAMETER CompanyId
    ID of the company to assign the duplicated procedure to

    .PARAMETER Name
    Optional new name for the duplicated procedure

    .PARAMETER Description
    Optional new description

    .EXAMPLE
    Duplicate-HuduProcedure -Id 123 -CompanyId 789 -Name "Cloned Procedure"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [Parameter(Mandatory)] [int]$CompanyId,
        [string]$Name,
        [string]$Description
    )

    $params = @{ company_id = $CompanyId }
    if ($Name) { $params.name = $Name }
    if ($Description) { $params.description = $Description }

    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/procedures/$Id/duplicate" -Params $params
        return $res.procedure
    } catch {
        Write-Warning "Failed to duplicate procedure ID $Id"
        return $null
    }
}
