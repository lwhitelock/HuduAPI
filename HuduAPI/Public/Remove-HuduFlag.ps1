function Remove-HuduFlag {
<#
.SYNOPSIS
Deletes a Flag.

.DESCRIPTION
Deletes a Flag by ID. This is destructive and cannot be undone (unless Hudu provides recovery).
Supports ShouldProcess for -WhatIf / -Confirm.

.PARAMETER Id
The Flag ID to delete.

.EXAMPLE
Remove-HuduFlag -Id 77

.EXAMPLE
Get-HuduFlags -flagable_type Company -flagable_id 123 | Remove-HuduFlag -WhatIf

.NOTES
API Endpoint: DELETE /api/v1/flags/{id}
#>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Alias('FlagId')]
        [int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess("Flag Id=$Id", "Delete")) {
            Invoke-HuduRequest -Method DELETE -Resource "/api/v1/flags/$Id" | Out-Null
        }
    }
}