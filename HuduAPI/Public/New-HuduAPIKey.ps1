function New-HuduAPIKey {
    <#
    .SYNOPSIS
    Set Hudu API Key

    .DESCRIPTION
    API keys are required to interact with Hudu

    .PARAMETER ApiKey
    The API key

    .EXAMPLE
    New-HuduAPIKey -ApiKey abdc1234

    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '', Scope = 'Function')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Scope = 'Function')]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [String]$ApiKey
    )

    process {
        if ($ApiKey) {
            $SecApiKey = ConvertTo-SecureString $ApiKey -AsPlainText -Force
        } else {
            $SecApiKey = Read-Host -Prompt 'Please enter your Hudu API key, you can obtain it from https://your-hudu-domain/admin/api_keys:' -AsSecureString
        }
        Set-Variable -Name 'Int_HuduAPIKey' -Value $SecApiKey -Visibility Private -Scope script -Force

        if ($script:Int_HuduBaseURL) {
            [version]$version = (Get-HuduAppInfo).version
            if ($version -lt $script:HuduRequiredVersion) {
                Write-Warning "A connection error occured or Hudu version is below $script:HuduRequiredVersion"
            }
        }
    }
}
