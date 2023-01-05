function Set-HuduArticleArchive {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id,
    [Parameter(Mandatory = $true)]
    [Bool]$Archive
  )
    
  if ($Archive) {
    $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$Id/archive"
  } else {
    $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$Id/unarchive"
  }
  $Response
}