function Remove-HuduPassword {
  Param (
    [Parameter(Mandatory=$true)][Int]$id =''
  )
    
  $response = Invoke-HuduRequest -Method post -Resource "/api/v1/asset_passwords/$id"
  
  $response
  
  
}