function Set-HuduArticle {
    <#
    .SYNOPSIS
    Update a Knowledge Base Article

    .DESCRIPTION
    Uses Hudu API to update KB Article

    .PARAMETER Name
    Name of the Article

    .PARAMETER Content
    Article Content

    .PARAMETER EnableSharing
    Set article to public and generate a URL

    .PARAMETER FolderId
    Used to associate article with folder

    .PARAMETER CompanyId
    Used to associate article with company

    .PARAMETER ArticleId
    Id of the requested article

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    Set-HuduArticle -ArticleId 1 -Name 'Article Name' -Content '<h1>New article contents</h1>'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [String]$Name,

        [String]$Content,
        [switch]$EnableSharing,

        [Alias('folder_id')]
        [Int]$FolderId = '',

        [Alias('company_id')]
        [Int]$CompanyId = '',

        [Alias('article_id', 'id')]
        [Parameter(Mandatory = $true)]
        [Int]$ArticleId,

        [string]$Slug
    )
    
    $Object = Get-HuduArticles -Id $ArticleId
    $Article = [ordered]@{article = $Object.article }

    if ($Name) {
        $Article.article.name = $Name
    }
    
    if ($Content) {
        $Article.article.content = $Content
    }
    
    if ($FolderId) {
        $Article.article.folder_id = $FolderId
    }

    if ($CompanyId) {
        $Article.article.company_id = $CompanyId
    }

    if ($EnableSharing.IsPresent) {
        $Article.article.enable_sharing = $true
    }

    if ($Slug) {
        $Article.article.slug = $Slug
    }

    $JSON = $Article | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$ArticleId" -Body $JSON
    }
}
