function Remove-HuduLabel {
<#
.SYNOPSIS
Deletes a Label.

.DESCRIPTION
Deletes a Label by ID. Supports ShouldProcess for -WhatIf / -Confirm.

.PARAMETER Id
The Label ID to delete.

.EXAMPLE
Remove-HuduLabel -Id 77

.EXAMPLE
Get-HuduLabels -Labelable_Type Asset -Labelable_Id 123 | Remove-HuduLabel -WhatIf

.NOTES
API Endpoint: DELETE /api/v1/labels/{id}
#>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('LabelId','label_id')]
        [int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess("Label Id=$Id", "Delete")) {
            Invoke-HuduRequest -Method DELETE -Resource "/api/v1/labels/$Id" | Out-Null
            return $true
        }
    }
}
