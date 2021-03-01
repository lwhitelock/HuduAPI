function Set-HuduArticleArchive {
    Param (
      [Parameter(Mandatory=$true)]
      [Int]$id ='',
      [Parameter(Mandatory=$true)]
      [Bool]$archive=''
    )
    
    if ($archive){
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$id/archive"
    } else {
        $response = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$id/unarchive"
    }
    $response
  }