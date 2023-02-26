function New-HuduArticle {
    <#
    .SYNOPSIS
    Create a Knowledge Base Article

    .DESCRIPTION
    Uses Hudu API to create KB articles

    .PARAMETER Name
    Name of article

    .PARAMETER Content
    Article HTML contents

    .PARAMETER EnableSharing
    Create public URL for users to view without being authenticated

    .PARAMETER FolderId
    Associate article with folder id

    .PARAMETER CompanyId
    Associate article with company id

    .PARAMETER Slug
    Manually define slug for Article

    .EXAMPLE
    New-HuduArticle -Name "Test" -CompanyId 1 -Content '<h1>Testing</h1>' -EnableSharing -Slug 'this-is-a-test'

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
        Invoke-HuduRequest -Method post -Resource '/api/v1/articles' -Body $JSON
    }
}
