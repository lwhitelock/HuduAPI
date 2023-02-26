function Remove-HuduBaseURL {
    <#
    .SYNOPSIS
    Remove base URL

    .DESCRIPTION
    Unsets the Hudu Base URL variable

    .EXAMPLE
    Remove-HuduBaseURL

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param()
    if ($PSCmdlet.ShouldProcess('Base URL')) {
        Remove-Variable -Name 'Int_HuduBaseURL' -Scope script -Force
    }
}
