function Get-HuduArticles {
	Param (
		[Int]$id = '',
		[Int]$companyid = '',
		[String]$name =''
	
	)
	
	#
	$i = 1;
	$AllArticles = do {
		$Articles = hudu_request -Method get -Resource "/api/v1/articles?page=$i&page_size=1000"
		$i++
		$Articles.Articles
	} while ($Articles.Articles.count % 1000 -eq 0 -and $Articles.Articles.count -ne 0)
		
		
	if ($id) {
	$AllArticles = $AllArticles | where-object {$_.id -eq $id}
	}
		
	if ($name) {
	$AllArticles = $AllArticles | where-object {$_.name -eq $name}
	}
		
	if ($companyid) {
	$AllArticles = $AllArticles | where-object {$_.company_id -eq $companyid}
	}
	
	
	return $AllArticles
	
}

function New-HuduArticle {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[String]$content='',
		[Int]$folder_id='',
		[Int]$company_id=''
	)
	

	$article = @{article = @{}}
	
	$article.article.add('name',$name)
	$article.article.add('content',$content)
	
	if ($folder_id) {
	$article.article.add('folder_id',$folder_id)
	}
	
	if ($company_id) {
	$article.article.add('company_id',$company_id)
	}
	
	$json = $article | convertto-json -Depth 10
	
	$response = hudu_request -Method post -Resource "/api/v1/articles" -body $json
	
	$response
	
	
}
		
function Set-HuduArticle {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[String]$content='',
		[Int]$folder_id='',
		[Int]$company_id='',
		[Parameter(Mandatory=$true)]
		[Int]$article_id
	)
	

	$article = @{article = @{}}
	
	$article.article.add('name',$name)
	$article.article.add('content',$content)
	
	if ($folder_id) {
	$article.article.add('folder_id',$folder_id)
	}
	
	if ($company_id) {
	$article.article.add('company_id',$company_id)
	}
	
	$json = $article | convertto-json -Depth 10
	
	$response = hudu_request -Method put -Resource "/api/v1/articles/$article_id" -body $json
	
	$response
	
	
}