function Set-HuduPassword {
  Param (
    [Parameter(Mandatory=$true)][Int]$id ='',
    [Parameter(Mandatory=$true)][Int]$company_id='',
    [String]$passwordable_type='',
    [int]$passwordable_id='',
    [bool]$in_portal,
    [Parameter(Mandatory=$true)][String]$password='',
    [string]$otp_secret='',
    [String]$url='',
    [String]$username='',
    [String]$description='',
    [String]$password_type='',
    [String]$name=''
    
  )

  $PasswordObject = @{
    asset_password = @{
  
      name = $name
      company_id = $company_id
      passwordable_type = $passwordable_type
      passwordable_id = $passwordable_id
      in_portal= $in_portal
      password = $password
      otp_secret = $otp_secret
      url = $url
      username = $username
      description = $description
      password_type = $password_type

    }
  }

  #remove Empty Keys

  ($PasswordObject.asset_password.GetEnumerator() | ? { -not $_.Value }) | % { $PasswordObject.asset_password.Remove($_.Name) }

  
  #$json = $Password | convertto-json -Depth 5

  write-host $(convertto-json $PasswordObject)
  
  $response = Invoke-HuduRequest -Method 'put' -Resource "/api/v1/asset_passwords/$id" -body $(convertto-json $PasswordObject)
  
  $response
  
  
}