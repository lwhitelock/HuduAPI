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

    if (!$BaseURL) {
        $BaseURL = Read-Host -Prompt 'Please enter your Hudu Base URL with no trailing /, for example https://demo.huducloud.com :'
    }
    Set-Variable -Name 'Int_HuduBaseURL' -Value $BaseURL -Visibility Private -Scope script -Force

    if ($script:Int_HuduAPIKey) {
        [version]$Version = (Get-HuduAppInfo).version
        if ($Version -lt $script:HuduRequiredVersion) {
            Write-Warning "A connection error occured or Hudu version is below $script:HuduRequiredVersion"
        }
    }
}
