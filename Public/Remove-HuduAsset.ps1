function Remove-HuduAsset {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id,
    [Alias("company_id")]
    [Parameter(Mandatory = $true)]
    [Int]$CompanyId
  )
      
  $Response = Invoke-HuduRequest -Method delete -Resource "/api/v1/companies/$CompanyId/assets/$Id"
    
  $Response
    
}