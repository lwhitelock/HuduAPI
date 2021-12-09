function Remove-HuduArticle {
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id = ''
  )
      
  $Response = Invoke-HuduRequest -Method delete -Resource "/api/v1/articles/$Id"
    
  $Response
    
}