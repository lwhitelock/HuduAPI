function Set-HuduPassword {
  [CmdletBinding()]
  # This will silence the warning for variables with Password in their name.
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "")]
  Param (
    [Parameter(Mandatory = $true)] 
    [Int]$Id,
    [Parameter(Mandatory = $true)]
    [String]$Name,
    [Alias("company_id")]
    [Parameter(Mandatory = $true)]
    [Int]$CompanyId,
    [Alias("passwordable_type")]
    [String]$PasswordableType = '',
    [Alias("passwordable_id")]
    [int]$PasswordableId = '',
    [Alias("in_portal")]
    [Bool]$InPortal = $false,
    [Parameter(Mandatory = $true)]
    [String]$Password = '',
    [Alias("otp_secret")]
    [string]$OTPSecret = '',
    [String]$URL = '',
    [String]$Username = '',
    [String]$Description = '',
    [Alias("password_type")]
    [String]$PasswordType = ''
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
  
  $JSON = $AssetPassword | convertto-json -Depth 10
  
  $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$Id" -body $JSON
  
  $Response
}