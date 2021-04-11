function New-HuduArticle {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[String]$content='',
		[Int]$folder_id='',
		[Int]$company_id=''
	)
	

	$article = [ordered]@{article = [ordered]@{}}
	
	$article.article.add('name',$name)
	$article.article.add('content',$content)
	
	if ($folder_id) {
	$article.article.add('folder_id',$folder_id)
	}
	
	if ($company_id) {
	$article.article.add('company_id',$company_id)
	}
	
	$json = $article | convertto-json -Depth 10
	
	$response = Invoke-HuduRequest -Method post -Resource "/api/v1/articles" -body $json
	
	$response
	
	
}