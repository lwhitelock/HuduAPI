function Set-HuduPasswordArchive {
    Param (
      [Parameter(Mandatory=$true)]
      [Int]$id ='',
      [Parameter(Mandatory=$true)]
      [Bool]$archive=''
    )
    
    if ($archive){
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$id/archive"
    } else {
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/asset_passwords/$id/unarchive"
    }
    $response
  }