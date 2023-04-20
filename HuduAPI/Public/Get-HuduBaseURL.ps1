function Get-HuduBaseURL {
    <#
    .SYNOPSIS
    Get Hudu Base URL

    .DESCRIPTION
    Returns Hudu Base URL

    .EXAMPLE
    Get-HuduBaseURL

    #>
    [CmdletBinding()]
    Param()
    if ($null -eq $script:Int_HuduBaseURL) {
        throw 'No Base URL has been set. Please use New-HuduBaseURL to set it.'
    } else {
        $script:Int_HuduBaseURL
    }
}
