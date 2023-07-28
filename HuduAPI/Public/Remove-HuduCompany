function Remove-HuduCompany {
    <#
    .SYNOPSIS
    Delete a Website

    .DESCRIPTION
    Uses Hudu API to delete a company

    .PARAMETER Id
    Id of the Company to delete

    .EXAMPLE
    Remove-HuduCompany -Id 1

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method delete -Resource "/api/v1/companies/$Id"
        }
    }
}
