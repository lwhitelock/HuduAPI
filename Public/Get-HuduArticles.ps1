function Get-HuduArticles {
	[CmdletBinding()]
	Param (
		[Int]$Id = '',
		[Alias("company_id")]
		[Int]$CompanyId = '',
		[String]$Name = ''
	)
	
	if ($Id) {
		$Article = Invoke-HuduRequest -Method get -Resource "/api/v1/articles/$Id"
		return $Article
	} else {

		$ResourceFilter = ''

		if ($CompanyId) {
			$ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
		}

		if ($Name) {
			$ResourceFilter = "$($ResourceFilter)&name=$($Name)"
		}
	
		$i = 1;
		$AllArticles = do {
			$Articles = Invoke-HuduRequest -Method get -Resource "/api/v1/articles?page=$i&page_size=1000$($ResourceFilter)"
			$i++
			$Articles.Articles
		} while ($Articles.Articles.count % 1000 -eq 0 -and $Articles.Articles.count -ne 0)
		
		return $AllArticles
	
	}
}