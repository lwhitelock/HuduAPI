function Remove-HuduProcedure {
    <#
    .SYNOPSIS
    Delete a procedure

    .DESCRIPTION
    Permanently deletes a procedure by ID.

    .PARAMETER Id
    ID of the procedure to delete

    .EXAMPLE
    Remove-HuduProcedure -Id 7
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)] [int]$Id
    )
    $response = $null
    try {
        $response = Invoke-HuduRequest -Method DELETE -Resource "/api/v1/procedures/$Id"
        Write-Host "Successfully deleted procedure ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete procedure ID $Id"
    }
    return $response
}
