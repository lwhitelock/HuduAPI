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
    associated Object type, most commonly asset, for the password ["Asset"]

    .PARAMETER PasswordableId
    Associated object id for the password

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
        [ValidateScript({Assert-AllowedObjectType -InputType $_ -AllowedCanonicals @(
                "Asset"
        )})]         
        [String]$PasswordableType,

        [Alias('passwordable_id')]
        [int]$PasswordableId,

        [Alias('in_portal')]
        [Bool]$InPortal = $false,
        [String]$Password,

        [Alias('otp_secret')]
        [string]$OTPSecret,

        [String]$URL,

        [String]$Username,

        [String]$Description,

        [Alias('password_type')]
        [String]$PasswordType,

        [Alias('password_folder_id')]
        [int]$PasswordFolderId,

        [string]$Slug
    )

    $Object = Get-HuduPasswords -Id $Id 
    $AssetPassword = [ordered]@{asset_password = $Object }

    if ($PSBoundParameters.ContainsKey('Name'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name name -Force -Value $Name   
    }
    if ($PSBoundParameters.ContainsKey('CompanyId'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name company_id -Force -Value $CompanyId
    }
    if ($PSBoundParameters.ContainsKey('Password'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name password -Force -Value $Password
    }
    if ($PSBoundParameters.ContainsKey('InPortal'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name in_portal -Force -Value $InPortal
    }
    if ($PSBoundParameters.ContainsKey('OTPSecret'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name otp_secret -Force -Value $OTPSecret
    }
    if ($PSBoundParameters.ContainsKey('URL'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name url -Force -Value $URL
    }
    if ($PSBoundParameters.ContainsKey('Username'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name username -Force -Value $Username
    }
    if ($PSBoundParameters.ContainsKey('Description'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name description -Force -Value $Description
    }
    if ($PSBoundParameters.ContainsKey('PasswordType'))   { 
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name password_type -Force -Value $PasswordType
    }
    if ($PSBoundParameters.ContainsKey('PasswordableType')) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name passwordable_type -Force -Value $(Get-ObjectTypeFromCononical -inputData $PasswordableType)
    }
    if ($PSBoundParameters.ContainsKey('PasswordFolderId') -and ($PasswordFolderId -gt 0 -or $null -eq $PasswordFolderId)) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name password_folder_id -Force -Value $PasswordFolderId
    }    
    if ($PSBoundParameters.ContainsKey('PasswordableId') -and ($PasswordableId -gt 0 -or $null -eq $PasswordableId)) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name passwordable_id -Force -Value $PasswordableId
    }
    if ($Slug) {
        $AssetPassword.asset_password | Add-Member -MemberType NoteProperty -Name slug -Force -Value $Slug
    }
    $JSON = $AssetPassword | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$Id" -Body $JSON
    }
}
