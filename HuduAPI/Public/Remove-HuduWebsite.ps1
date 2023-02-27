function Remove-HuduWebsite {
    <#
    .SYNOPSIS
    Delete a Website

    .DESCRIPTION
    Uses Hudu API to delete a website

    .PARAMETER Id
    Id of the requested Website

    .EXAMPLE
    Remove-HuduWebsite -Id 1

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method delete -Resource "/api/v1/websites/$Id"
        }
    }
}
