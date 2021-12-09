function Set-HuduPasswordArchive {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id,
    [Parameter(Mandatory = $true)]
    [Bool]$Archive
  )
    
  if ($Archive) {
    $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$Id/archive"
  } else {
    $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$Id/unarchive"
  }
  $Response
}