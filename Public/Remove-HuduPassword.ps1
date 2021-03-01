function Remove-HuduPassword {
  Param (
    [Parameter(Mandatory=$true)]
    [Int]$id =''
  )
    
  $response = Invoke-HuduRequest -Method delete -Resource "/api/v1/asset_passwords/$id"
  
  $response
  
}