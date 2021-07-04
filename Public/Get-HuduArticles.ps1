function Get-HuduArticles {
	Param (
		[Int]$Id = '',
		[Alias("company_id")]
		[Int]$CompanyId = '',
		[String]$Name =''
	
	)
	
	if ($id) {
		$Article = Invoke-HuduRequest -Method get -Resource "/api/v1/articles/$Id"
		return $Article
	} else {

		$resourcefilter = ''

		if ($CompanyId) {
			$resourcefilter = "$($resourcefilter)&companyid=$($CompanyId)"
		}

		if ($Name) {
			$resourcefilter = "$($resourcefilter)&name=$($Name)"
		}
	
		$i = 1;
		$AllArticles = do {
			$Articles = Invoke-HuduRequest -Method get -Resource "/api/v1/articles?page=$i&page_size=1000$($resourcefilter)"
			$i++
			$Articles.Articles
		} while ($Articles.Articles.count % 1000 -eq 0 -and $Articles.Articles.count -ne 0)
		
	
		return $AllArticles
	
	}
}