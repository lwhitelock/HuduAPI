function Get-HuduPasswords {
  param(
      [Int]$id = '',        #Return Password by ID (from API)
		  [Int]$companyid = '', #Filter Passwords by Company ID
		  [String]$name =''     #Filter Passwords By Name
  )
  
  Add-Type -AssemblyName System.Web
  
  $ParamCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
  $ParamCollection.add('page', 1)
  $ParamCollection.add('page_size',29)

  if ($id) {
      $Resource = "/api/v1/asset_passwords/$($id)"
  } else {
      $Resource = "/api/v1/asset_passwords"
  }
  
  $i = 1;
  
  #Pull multiple "Pages" of passwords with 1000 per page (make sure we get all possible objects)
  
  $AllPasswords = do {
    
    $ParamCollection['page']=$i
	  $return = hudu_request -method "GET" -Resource $( $Resource + '?' + $ParamCollection.ToString() )
	  $i++
    $Passwords = @()
    if ($return.asset_passwords) {
      $Passwords += $return.asset_passwords
    } else {
      $Passwords += $return.asset_password
    }
    $Passwords
	  Write-Host "Retrieved $($Passwords.count) Passwords" -ForegroundColor Yellow
    
	} while ($Passwords.count % 29 -eq 0 -and $Passwords.count -ne 0)
  
  
  #Since these cant be done by API we pull in all possible then filter out
  if ($companyid) {
    $AllPasswords = $AllPasswords | where-object {$_.company_id -eq $companyid}
  }
  
  if ($name) {
    $AllPasswords = $AllPasswords | where-object {$_.name -eq $name}
  }
  
  return $AllPasswords
}
