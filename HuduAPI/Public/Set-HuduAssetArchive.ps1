function Set-HuduAssetArchive {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id,
    [Alias("company_id")]
    [Parameter(Mandatory = $true)]
    [Int]$CompanyId,
    [Parameter(Mandatory = $true)]
    [Bool]$Archive
  )
    
  if ($Archive) {
    $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CompanyId/assets/$Id/archive"
  } else {
    $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CompanyId/assets/$Id/unarchive"
  }
  $Response
}