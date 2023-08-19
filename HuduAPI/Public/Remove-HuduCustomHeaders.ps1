function Remove-HuduCustomHeaders {
    <#
    .SYNOPSIS
    Remove Custom Headers that are injected into each request

    .DESCRIPTION
    Unsets the Hudu Custom Header variable

    .EXAMPLE
    Remove-HuduCustomHeaders

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param()
    if ($PSCmdlet.ShouldProcess('Custom Headers')) {
        Remove-Variable -Name 'Int_HuduCustomHeaders' -Scope script -Force
    }
}
