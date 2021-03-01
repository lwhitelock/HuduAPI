function Set-HuduCompanyArchive {
    Param (
      [Parameter(Mandatory=$true)]
      [Int]$id ='',
      [Parameter(Mandatory=$true)]
      [Bool]$archive=''
    )
    
    if ($archive -eq $true){
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$id/archive"
    } else {
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$id/unarchive"
    }
    $response
  }