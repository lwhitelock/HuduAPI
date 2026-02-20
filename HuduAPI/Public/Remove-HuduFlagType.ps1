function Remove-HuduFlagType {
<#
.SYNOPSIS
Deletes a Flag Type.

.DESCRIPTION
Deletes a Flag Type by ID. This may fail if the Flag Type is in use by existing Flags.
Supports ShouldProcess for -WhatIf / -Confirm.

.PARAMETER Id
The Flag Type ID to delete.

.EXAMPLE
Remove-HuduFlagType -Id 12

.EXAMPLE
Remove-HuduFlagType -Id 12 -WhatIf

.NOTES
API Endpoint: DELETE /api/v1/flag_types/{id}
#>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('FlagTypeId')]
        [int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess("Flag Type Id=$Id", "Delete")) {
            Invoke-HuduRequest -Method DELETE -Resource "/api/v1/flag_types/$Id" | Out-Null
            return $true
        }
    }
}
