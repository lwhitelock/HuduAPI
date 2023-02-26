function New-HuduPassword {
    <#
    .SYNOPSIS
    Create a Password

    .DESCRIPTION
    Uses Hudu API to create a new password

    .PARAMETER Name
    Name of the password

    .PARAMETER CompanyId
    Company id

    .PARAMETER PasswordableType
    Asset type for the password

    .PARAMETER PasswordableId
    Asset id for the password

    .PARAMETER InPortal
    Boolean for in portal

    .PARAMETER Password
    Password

    .PARAMETER OTPSecret
    OTP secret

    .PARAMETER URL
    Password URL

    .PARAMETER Username
    Username

    .PARAMETER Description
    Password description

    .PARAMETER PasswordType
    Password type

    .PARAMETER PasswordFolderId
    Password folder id

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    New-HuduPassword -Name 'Some website password' -Username 'user@domain.com' -Password '12345'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    # This will silence the warning for variables with Password in their name.
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '')]
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [Alias('company_id')]
        [Parameter(Mandatory = $true)]
        [Int]$CompanyId,

        [Alias('passwordable_type')]
        [String]$PasswordableType = '',

        [Alias('passwordable_id')]
        [int]$PasswordableId = '',

        [Alias('in_portal')]
        [Bool]$InPortal = $false,

        [Parameter(Mandatory = $true)]
        [String]$Password = '',

        [Alias('otp_secret')]
        [string]$OTPSecret = '',

        [String]$URL = '',

        [String]$Username = '',

        [String]$Description = '',

        [Alias('password_type')]
        [String]$PasswordType = '',

        [Alias('password_folder_id')]
        [int]$PasswordFolderId,

        [string]$Slug
    )

    $AssetPassword = [ordered]@{asset_password = [ordered]@{} }

    $AssetPassword.asset_password.add('name', $Name)
    $AssetPassword.asset_password.add('company_id', $CompanyId)
    $AssetPassword.asset_password.add('password', $Password)
    $AssetPassword.asset_password.add('in_portal', $InPortal)

    if ($PasswordableType) {
        $AssetPassword.asset_password.add('passwordable_type', $PasswordableType)
    }
    if ($PasswordableId) {
        $AssetPassword.asset_password.add('passwordable_id', $PasswordableId)
    }

    if ($OTPSecret) {
        $AssetPassword.asset_password.add('otp_secret', $OTPSecret)
    }

    if ($URL) {
        $AssetPassword.asset_password.add('url', $URL)
    }

    if ($Username) {
        $AssetPassword.asset_password.add('username', $Username)
    }

    if ($Description) {
        $AssetPassword.asset_password.add('description', $Description)
    }

    if ($PasswordType) {
        $AssetPassword.asset_password.add('password_type', $PasswordType)
    }

    if ($PasswordFolderId) {
        $AssetPassword.asset_password.add('password_folder_id', $PasswordFolderId)
    }

    if ($Slug) {
        $AssetPassword.asset_password.add('slug', $Slug)
    }

    $JSON = $AssetPassword | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method post -Resource '/api/v1/asset_passwords' -Body $JSON
    }
}
