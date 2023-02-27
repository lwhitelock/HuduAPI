function Set-HuduPasswordArchive {
    <#
    .SYNOPSIS
    Archive/Unarchive a Password

    .DESCRIPTION
    Uses Hudu API to archive or unarchive a password

    .PARAMETER Id
    Id of the requested Password

    .PARAMETER Archive
    Boolean of archive status

    .EXAMPLE
    Set-HuduPasswordArchive -Archive $true -Id 1

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id,
        [Parameter(Mandatory = $true)]
        [Bool]$Archive
    )

    process {
        if ($Archive) {
            $Action = 'archive'
        } else {
            $Action = 'unarchive'
        }

        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$Id/$Action"
        }
    }
}