function Remove-HuduUpload {
    <#
    .SYNOPSIS
    Delete an Upload by ID

    .DESCRIPTION
    Calls Hudu API to delete uploads by specifying the ID value

    .EXAMPLE
    Remove-HuduUpload

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method delete -Resource "/api/v1/uploads/$Id"
        }
    }
    
}
