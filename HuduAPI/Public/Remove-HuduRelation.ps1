function Remove-HuduRelation {
    <#
    .SYNOPSIS
    Delete a Relation

    .DESCRIPTION
    Uses Hudu API to delete object relationships

    .PARAMETER Id
    Id of the requested Relation

    .EXAMPLE
    Remove-HuduRelation -Id 1

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method delete -Resource "/api/v1/relations/$Id"
        }
    }
}
