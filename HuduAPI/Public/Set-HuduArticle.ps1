function Set-HuduArticle {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Parameter(Mandatory = $true)]
		[String]$Content,
		[Alias("folder_id")]
		[Int]$FolderId = '',
		[Alias("company_id")]
		[Int]$CompanyId = '',
		[Alias("article_id", "id")]
		[Parameter(Mandatory = $true)]
		[Int]$ArticleId
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
	
	$JSON = $Article | ConvertTo-Json -Depth 10
	
	$Response = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$ArticleId" -body $JSON
	
	$Response
	
}