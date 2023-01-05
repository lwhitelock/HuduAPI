function New-HuduArticle {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Parameter(Mandatory = $true)]
		[String]$Content,
		[Alias("folder_id")]
		[Int]$FolderId = '',
		[Alias("company_id")]
		[Int]$CompanyId = ''
	)
	

	$Article = [ordered]@{article = [ordered]@{} }
	
	$Article.article.add('name', $Name)
	$Article.article.add('content', $Content)
	
	if ($FolderId) {
		$Article.article.add('folder_id', $FolderId)
	}
	
	if ($CompanyId) {
		$Article.article.add('company_id', $CompanyId)
	}
	
	$JSON = $Article | convertto-json -Depth 10
	
	$Response = Invoke-HuduRequest -Method post -Resource "/api/v1/articles" -body $JSON
	
	$Response
	
}