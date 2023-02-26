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
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [Parameter(Mandatory = $true)]
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

    $Article = [ordered]@{article = [ordered]@{} }

    $Article.article.add('name', $Name)
    $Article.article.add('content', $Content)

    if ($FolderId) {
        $Article.article.add('folder_id', $FolderId)
    }

    if ($CompanyId) {
        $Article.article.add('company_id', $CompanyId)
    }

    if ($EnableSharing.IsPresent) {
        $Article.article.add('enable_sharing', 'true')
    }

    if ($Slug) {
        $Article.article.add('slug', $Slug)
    }

    $JSON = $Article | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$ArticleId" -Body $JSON
    }
}