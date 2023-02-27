function Set-HuduAssetArchive {
    <#
    .SYNOPSIS
    Archive/Unarchive an Asset

    .DESCRIPTION
    Uses Hudu API to archive or unarchive an asset

    .PARAMETER Id
    Id of the requested Asset

    .PARAMETER CompanyId
    Id of the requested parent company

    .PARAMETER Archive
    Boolean for archive status

    .EXAMPLE
    Set-HuduAssetArchive -Id 1 -CompanyId 1 -Archive $true

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,
        [Alias('company_id')]
        [Parameter(Mandatory = $true)]
        [Int]$CompanyId,
        [Parameter(Mandatory = $true)]
        [Bool]$Archive
    )

    if ($Archive) {
        $Action = 'archive'
    } else {
        $Action = 'unarchive'
    }

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CompanyId/assets/$Id/$Action"
    }
}
