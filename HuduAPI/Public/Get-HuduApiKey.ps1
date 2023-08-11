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
    if ($null -eq $script:Int_HuduAPIKey) {
        throw 'No API key has been set. Please use New-HuduAPIKey to set it.'
    } else {
        $script:Int_HuduAPIKey
    }
}
