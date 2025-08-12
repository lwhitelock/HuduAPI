function Remove-HuduProcedureTask {
    <#
    .SYNOPSIS
    Delete a procedure task

    .DESCRIPTION
    Permanently deletes a procedure task by ID.

    .PARAMETER Id
    ID of the task to delete

    .EXAMPLE
    Remove-HuduProcedureTask -Id 88
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)] [int]$Id
    )

    if ($PSCmdlet.ShouldProcess("Procedure Task ID $Id", "Delete")) {
        try {
            Invoke-HuduRequest -Method DELETE -Resource "/api/v1/procedure_tasks/$Id"
            Write-Host "Successfully deleted task ID $Id" -ForegroundColor Green
        } catch {
            Write-Warning "Failed to delete task ID $Id"
        }
    }
}
