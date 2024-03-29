function Get-HuduApiKey {
    <#
    .SYNOPSIS
    Get Hudu API key

    .DESCRIPTION
    Returns Hudu API key in securestring format

    .EXAMPLE
    Get-HuduApiKey

    #>
    [CmdletBinding()]
    Param()
    if ($null -eq $Int_HuduAPIKey) {
        Write-Error 'No API key has been set. Please use New-HuduAPIKey to set it.'
    } else {
        $Int_HuduAPIKey
    }
}
