function Remove-HuduAsset {
    <#
    .SYNOPSIS
    Delete an Asset

    .DESCRIPTION
    Uses Hudu API to remove an Asset from a company

    .PARAMETER Id
    Id of the requested Asset

    .PARAMETER CompanyId
    Id of the requested parent Company

    .EXAMPLE
    Remove-HuduAsset -CompanyId 1 -Id 1

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id,
        [Alias('company_id')]
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$CompanyId
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method delete -Resource "/api/v1/companies/$CompanyId/assets/$Id"
        }
    }
}
