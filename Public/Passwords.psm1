function Get-HuduPasswords {
  param(
      [Int]$id = '',        #Return Password by ID (from API)
		  [Int]$companyid = '', #Filter Passwords by Company ID
		  [String]$name =''     #Filter Passwords By Name
  )
  
  Add-Type -AssemblyName System.Web
  
  $ParamCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
  $ParamCollection.add('page', 1)
  $ParamCollection.add('page_size',1000)

  if ($id) {
      $Resource = "/api/v1/asset_passwords/$($id)"
  } else {
      $Resource = "/api/v1/asset_passwords"
  }
  
  $i = 1;
  
  #Pull multiple "Pages" of passwords with 1000 per page (make sure we get all possible objects)
  
  $AllPasswords = do {
    
    $ParamCollection['page']=$i
	  $response = hudu_request -method "GET" -Resource $( $Resource + '?' + $ParamCollection.ToString() )
	  $i++
    $Passwords = @()
    if ($response.asset_passwords) {
      $Passwords += $response.asset_passwords
    } else {
      $Passwords += $response.asset_password
    }
    $Passwords
	  Write-Host "Retrieved $($Passwords.count) Passwords" -ForegroundColor Yellow
    
	} while ($Passwords.count % 1000 -eq 0 -and $Passwords.count -ne 0)
  
  
  #Since these cant be done by API we pull in all possible then filter out
  if ($companyid) {
    $AllPasswords = $AllPasswords | where-object {$_.company_id -eq $companyid}
  }
  
  if ($name) {
    $AllPasswords = $AllPasswords | where-object {$_.name -eq $name}
  }
  
  return $AllPasswords
}

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
  
  $response = hudu_request -Method post -Resource "/api/v1/companies/$company_id/asset_passwords" -body $json
  
  $response
  
  
}
    
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
  
  $response = hudu_request -Method 'put' -Resource "/api/v1/asset_passwords/$id" -body $(convertto-json $PasswordObject)
  
  $response
  
  
}

function Remove-HuduPassword {
  Param (
    [Parameter(Mandatory=$true)][Int]$id =''
  )
    
  $response = hudu_request -Method post -Resource "/api/v1/asset_passwords/$id"
  
  $response
  
  
}