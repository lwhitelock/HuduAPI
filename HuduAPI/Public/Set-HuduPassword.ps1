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

        [String]$Name,

        [Alias('company_id')]
        [Int]$CompanyId,

        [Alias('passwordable_type')]
        [String]$PasswordableType = '',

        [Alias('passwordable_id')]
        [int]$PasswordableId = '',

        [Alias('in_portal')]
        [Bool]$InPortal = $false,
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

    $Object = Get-HuduPasswords -Id $Id 
    $AssetPassword = [ordered]@{asset_password = $Object }

    if ($Name) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name name -Force -Value $Name   
    }
    
    if ($CompanyId) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name company_id -Force -Value $CompanyId
    }
    
    if ($Password) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name password -Force -Value $Password
    }
    
    if ($InPortal) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name in_portal -Force -Value $InPortal
    }
    
    if ($OTPSecret) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name otp_secret -Force -Value $OTPSecret
    }
    if ($URL) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name url -Force -Value $URL
    }
    if ($Username) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name username -Force -Value $Username
    }
    if ($Description) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name description -Force -Value $Description
    }
    if ($PasswordType) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name password_type -Force -Value $PasswordType
    }
    if ($Slug) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name slug -Force -Value $Slug
    }
    # Can remove these by setting null
    if ($PSBoundParameters.ContainsKey('PasswordFolderId')) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name password_folder_id -Force -Value $PasswordFolderId
    }
    if ($PSBoundParameters.ContainsKey('PasswordableType')) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name passwordable_type -Force -Value $PasswordableType
    }
    if ($PSBoundParameters.ContainsKey('PasswordableId')) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name passwordable_id -Force -Value $PasswordableId
    }

    $JSON = $AssetPassword | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$Id" -Body $JSON
    }
}
