function Get-HuduAppInfo {
    <#
    .SYNOPSIS
    Retrieve information regarding API

    .DESCRIPTION
    Calls Hudu API to retrieve version number and date

    .EXAMPLE
    Get-HuduAppInfo

    #>
    [CmdletBinding()]
    Param()

    [version]$script:HuduRequiredVersion = '2.21'
    
    try {
        Invoke-HuduRequest -Resource '/api/v1/api_info'
    } catch {
        [PSCustomObject]@{
            version = '0.0.0.0'
            date    = '2000-01-01'
        }
    }
}
