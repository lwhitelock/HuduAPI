function Get-HuduPasswords {
  param(
      [Int]$id = '',        #Return Password by ID (from API)
		  [Int]$companyid = '', #Filter Passwords by Company ID
		  [String]$name =''     #Filter Passwords By Name
  )
  
  Add-Type -AssemblyName System.Web
  
  $ParamCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
  $ParamCollection.add('page',0)
  $ParamCollection.add('page_size',1000)

  if ($id) {
      $Resource = "api/v1/asset_passwords/$id"
  } else {
      $Resource = "api/v1/asset_passwords"+
  }
  
  $i = 0;
  
  #Pull multiple "Pages" of passwords with 1000 per page (make sure we get all possible objects)
  
  $AllPasswords = do {
  
    $ParamCollection.page=$i
	  $Pass = hudu_request -resource ( $Resource + "?" + $ParamCollection.ToString() ) -method "GET"
	  $i++
	  $Pass
	  Write-Host "Retrieved $($pass.count) Passwords" -ForegroundColor Yellow
    
	} while ($Pass.count % 1000 -eq 0 -and $Pass.count -ne 0)
  
  
  #Since these cant be done by API we pull in all possible then filter out
  if ($companyid) {
    $AllPasswords = $AllPasswords | where-object {$_.company_id -eq $companyid}
  }
  
  if ($name) {
    $AllPasswords = $AllPasswords | where-object {$_.name -eq $name}
  }
  
  return $AllPasswords
}
