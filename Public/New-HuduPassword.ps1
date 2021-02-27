function New-HuduPassword {
  Param (
    [Parameter(Mandatory=$true)]
    [String]$name ='',
    [Parameter(Mandatory=$true)]
    [Int]$company_id='',
    [String]$passwordable_type='',
    [int]$passwordable_id='',
    $in_portal,
    [String]$password='',
    [string]$otp_secret='',
    [String]$url='',
    [String]$username='',
    [String]$description='',
    [String]$password_type=''
  )
  

  $password = @{asset_password = @{}}
  
  $password.asset_password.add('name',$name)
  $password.asset_password.add('company_id',$company_id)
  $password.asset_password.add('passwordable_type',$passwordable_type)
  $password.asset_password.add('passwordable_id',$passwordable_id)
  $password.asset_password.add('in_portal',$in_portal)
  $password.asset_password.add('password',$password)
  $password.asset_password.add('otp_secret',$otp_secret)
  $password.asset_password.add('url',$url)
  $password.asset_password.add('username',$username)
  $password.asset_password.add('description',$description)
  $password.asset_password.add('password_type',$password_type)
  
  $json = $password | convertto-json -Depth 10
  
  $response = Invoke-HuduRequest -Method post -Resource "/api/v1/companies/$company_id/asset_passwords" -body $json
  
  $response
  
  
}