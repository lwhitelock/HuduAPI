function Remove-HuduPassword {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id
  )
    
  $Response = Invoke-HuduRequest -Method delete -Resource "/api/v1/asset_passwords/$Id"
  
  $Response
  
}