function New-HuduCustomHeaders {
    <#
    .SYNOPSIS
    Set Hudu custom headers to be injected into each request

    .DESCRIPTION
    There may be times when one might need to use custom headers e.g. Service Tokens for Cloudflare Zero Trust

    .PARAMETER Headers
    Hashtable with the Custom Headers that need to be injected into each request

    .EXAMPLE
    New-HuduCustomHeaders -Headers @{"CF-Access-Client-Id" = "x"; "CF-Access-Client-Secret" = "y"}

    .NOTES
    General notes
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Scope = 'Function')]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
        [hashtable]
        $Headers
    )
    process {
        if ($Headers.Count -eq 0) {
            Write-Host "Empty Custom Header hashtable was provided, no Custom Headers will be set"
            return 0
        }
        
        Set-Variable -Name 'Int_HuduCustomHeaders' -Value $Headers -Visibility Private -Scope script -Force
    }
}
