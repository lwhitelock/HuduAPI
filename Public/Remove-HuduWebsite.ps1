function Remove-HuduWebsite {
    Param (
      [Parameter(Mandatory=$true)]
      [Int]$id =''
    )
      
    $response = Invoke-HuduRequest -Method delete -Resource "/api/v1/websites/$id"
    
    $response
    
  }