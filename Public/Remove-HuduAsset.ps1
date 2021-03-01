function Remove-HuduAsset {
    Param (
      [Parameter(Mandatory=$true)]
      [Int]$id ='',
      [Parameter(Mandatory=$true)]
      [Int]$company_id =''
    )
      
    $response = Invoke-HuduRequest -Method delete -Resource "/api/v1/companies/$company_id/assets/$id"
    
    $response
    
  }