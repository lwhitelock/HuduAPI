function Remove-HuduLabelType {
<#
.SYNOPSIS
Deletes a Label Type.

.DESCRIPTION
Deletes a Label Type by ID. This may fail if the Label Type is in use by existing Labels.
Supports ShouldProcess for -WhatIf / -Confirm.

.PARAMETER Id
The Label Type ID to delete.

.EXAMPLE
Remove-HuduLabelType -Id 12

.EXAMPLE
Remove-HuduLabelType -Id 12 -WhatIf

.NOTES
API Endpoint: DELETE /api/v1/label_types/{id}
#>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('LabelTypeId','label_type_id')]
        [int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess("Label Type Id=$Id", "Delete")) {
            Invoke-HuduRequest -Method DELETE -Resource "/api/v1/label_types/$Id" | Out-Null
            return $true
        }
    }
}
