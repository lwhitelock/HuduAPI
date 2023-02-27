function Remove-HuduPassword {
    <#
    .SYNOPSIS
    Delete a Password

    .DESCRIPTION
    Uses Hudu API to remove asset password

    .PARAMETER Id
    Id of the password

    .EXAMPLE
    Remove-HuduPassword -Id 1

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id
    )
    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method delete -Resource "/api/v1/asset_passwords/$Id"
        }
    }
}
