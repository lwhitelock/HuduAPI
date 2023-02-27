function Set-HuduCompanyArchive {
    <#
    .SYNOPSIS
    Archive/Unarchive a company

    .DESCRIPTION
    Uses Hudu API to set archive status on a company

    .PARAMETER Id
    Id of the requested company

    .PARAMETER Archive
    Boolean for archive status

    .EXAMPLE
    Set-HuduCompanyArchive -Id 1 -Archive $true

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,
        [Parameter(Mandatory = $true)]
        [Bool]$Archive
    )

    if ($Archive -eq $true) {
        $Action = 'archive'
    } else {
        $Action = 'unarchive'
    }
    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$Id/$Action"
    }
}
