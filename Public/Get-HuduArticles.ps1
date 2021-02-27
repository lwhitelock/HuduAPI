function Get-HuduArticles {
	Param (
		[Int]$id = '',
		[Int]$companyid = '',
		[String]$name =''
	
	)
	
	#
	$i = 1;
	$AllArticles = do {
		$Articles = Invoke-HuduRequest -Method get -Resource "/api/v1/articles?page=$i&page_size=1000"
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
