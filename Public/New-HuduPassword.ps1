function New-HuduPassword {
  Param (
    [Parameter(Mandatory=$true)]
    [String]$name ='',
    [Parameter(Mandatory=$true)]
    [Int]$company_id='',
    [String]$passwordable_type='',
    [int]$passwordable_id='',
    [Bool]$in_portal = $false,
    [Parameter(Mandatory=$true)]
    [String]$password='',
    [string]$otp_secret='',
    [String]$url='',
    [String]$username='',
    [String]$description='',
    [String]$password_type=''
  )
  
  $asset_password = [ordered]@{asset_password = [ordered]@{}}
      
  $asset_password.asset_password.add('name',$name)
  $asset_password.asset_password.add('company_id',$company_id)
  $asset_password.asset_password.add('password',$password)
  $asset_password.asset_password.add('in_portal',$in_portal)

  if ($passwordable_type){
  $asset_password.asset_password.add('passwordable_type',$passwordable_type)
  }
  if ($passwordable_id){
  $asset_password.asset_password.add('passwordable_id',$passwordable_id)
  }
 
  if ($otp_secret){
    $asset_password.asset_password.add('otp_secret',$otp_secret)
  }

  if ($url){
    $asset_password.asset_password.add('url',$url)
  }

  if ($username){
    $asset_password.asset_password.add('username',$username)
  }

  if ($description){
    $asset_password.asset_password.add('description',$description)
  }

  if ($password_type){
    $asset_password.asset_password.add('password_type',$password_type)
  }
  
  $json = $asset_password | convertto-json -Depth 10
  
  $response = Invoke-HuduRequest -Method post -Resource "/api/v1/asset_passwords" -body $json
  
  $response
  
  
}