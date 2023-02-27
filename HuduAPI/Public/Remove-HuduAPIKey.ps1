function Remove-HuduAPIKey {
    <#
    .SYNOPSIS
    Remove API key

    .DESCRIPTION
    Unsets the variable for the Hudu API Key

    .EXAMPLE
    Remove-HuduAPIKey

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param()

    if ($PSCmdlet.ShouldProcess('API Key')) {
        Remove-Variable -Name 'Int_HuduAPIKey' -Scope script -Force
    }
}