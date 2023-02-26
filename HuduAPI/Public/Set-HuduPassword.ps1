function Set-HuduPassword {
    <#
    .SYNOPSIS
    Update a Password

    .DESCRIPTION
    Uses Hudu API to update a password

    .PARAMETER Id
    Id of the requested Password

    .PARAMETER Name
    Password name

    .PARAMETER CompanyId
    Id of requested company

    .PARAMETER PasswordableType
    Type of asset to associate with the password

    .PARAMETER PasswordableId
    Id of the asset to associate with the password

    .PARAMETER InPortal
    Display password in portal

    .PARAMETER Password
    Password

    .PARAMETER OTPSecret
    OTP secret

    .PARAMETER URL
    Url for the password

    .PARAMETER Username
    Username

    .PARAMETER Description
    Password description

    .PARAMETER PasswordType
    Password type

    .PARAMETER PasswordFolderId
    Id of requested password folder

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    Set-HuduPassword -Id 1 -CompanyId 1 -Password 'this_is_my_new_password'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    # This will silence the warning for variables with Password in their name.
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '')]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,

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

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$Id" -Body $JSON
    }
}
