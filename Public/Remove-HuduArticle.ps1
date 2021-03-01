function Remove-HuduArticle {
    Param (
      [Parameter(Mandatory=$true)]
      [Int]$id =''
    )
      
    $response = Invoke-HuduRequest -Method delete -Resource "/api/v1/articles/$id"
    
    $response
    
  }