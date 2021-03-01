function Set-HuduAssetArchive {
    Param (
      [Parameter(Mandatory=$true)]
      [Int]$id ='',
      [Parameter(Mandatory=$true)]
      [Int]$company_id ='',
      [Parameter(Mandatory=$true)]
      [Bool]$archive=''
    )
    
    if ($archive){
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$company_id/assets/$id/archive"
    } else {
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$company_id/assets/$id/unarchive"
    }
    $response
  }