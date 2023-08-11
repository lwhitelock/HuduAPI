function New-HuduBaseURL {
    <#
    .SYNOPSIS
    Set Hudu Base URL

    .DESCRIPTION
    In order to access the Hudu API the Base URL must be set

    .PARAMETER BaseURL
    Url with no trailing slash e.g. https://demo.huducloud.com

    .EXAMPLE
    New-HuduBaseURL -BaseURL https://demo.huducloud.com

    .NOTES
    General notes
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Scope = 'Function')]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true)]
        [String]
        $BaseURL
    )
    process {
        if (!$BaseURL) {
            $BaseURL = Read-Host -Prompt 'Please enter your Hudu Base URL with no trailing /, for example https://demo.huducloud.com :'
        }
            
        $Protocol = $BaseURL[0..7] -join ''
            if ($Protocol -ne 'https://') {
                if ($Protocol -like 'http://*') {
                    Write-Warning "Non HTTPS Base URL was set, rewriting URL to be secure transport only. If connection fails please make sure hostname is correct and HTTPS is enabld."
                    $BaseURL = $BaseURL.Replace('http://','https://')
                }
                else {
                    Write-Warning "No protocol was specified, adding https:// to the beginning of the specified hostname"
                    $BaseURL = "https://$BaseURL"
                }
            }
        
        Set-Variable -Name 'Int_HuduBaseURL' -Value $BaseURL -Visibility Private -Scope script -Force

        if ($script:Int_HuduAPIKey) {
            [version]$Version = (Get-HuduAppInfo).version
            if ($Version -lt $script:HuduRequiredVersion) {
                Write-Warning "A connection error occured or Hudu version is below $script:HuduRequiredVersion"
            }
        }
    }
}
