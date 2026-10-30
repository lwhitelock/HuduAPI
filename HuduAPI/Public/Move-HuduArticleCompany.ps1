function Move-HuduArticleCompany {
    <#
    .SYNOPSIS
    Move a Knowledge Base Article to a different company

    .DESCRIPTION
    Uses Hudu API to update an article's company_id via PUT /api/v1/articles/{id}

    .PARAMETER ArticleId
    Id of the article to move

    .PARAMETER CompanyId
    Destination company id. Use $null to move the article to the central Knowledge Base.

    .PARAMETER FolderId
    Optional destination-company folder id. When omitted, the article is moved
    to the root of the destination company's Knowledge Base.

    .EXAMPLE
    Move-HuduArticleCompany -ArticleId 1 -CompanyId 20

    .EXAMPLE
    Move-HuduArticleCompany -ArticleId 1 -CompanyId $null # moves to central kb

    .EXAMPLE
    Move-HuduArticleCompany -ArticleId 1 -CompanyId 20 -FolderId 5
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (

        [Alias('article_id', 'id')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$ArticleId,

        [Alias('company_id','new_company_id','destination_company_id','target_company_id')]
        [Parameter(Mandatory = $true)]
        [AllowNull()]
        [Nullable[int]]$CompanyId,

        [Alias('folder_id')]
        [ValidateRange(1, [int]::MaxValue)]
        [Nullable[int]]$FolderId
    )

    if ($null -ne $CompanyId -and $CompanyId -lt 1) {
        throw "CompanyId must be a positive integer, or `$null for the central Knowledge Base."
    }

    $DestinationDescription = if ($null -eq $CompanyId) { 'central Knowledge Base' } else { "company $CompanyId" }

    $DestinationFolderId = $null
    if ($PSBoundParameters.ContainsKey('FolderId')) {
        $Folder = Get-HuduFolders -Id $FolderId
        if (-not $Folder) {
            throw "Destination folder $FolderId could not be found."
        }
        $FolderCompanyId = if ($null -eq $Folder.company_id) { $null } else { [int]$Folder.company_id }
        if ($FolderCompanyId -ne $CompanyId) {
            throw "Destination folder $FolderId does not belong to $DestinationDescription."
        }
        $DestinationFolderId = $FolderId
    }

    # Hudu rejects a company change while folder_id still references a folder
    # owned by the source company. Explicitly clear it unless a validated
    # destination-company folder was supplied.
    $Article = [ordered]@{
        article = [ordered]@{
            company_id = $CompanyId
            folder_id  = $DestinationFolderId
        }
    }
    $JSON = $Article | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess("Article ID: $ArticleId", "Move to $DestinationDescription")) {
        $Result = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$ArticleId" -Body $JSON

        # Invoke-HuduRequest returns $null after a failed retry, so verify the
        # persisted state instead of silently reporting a successful move.
        $VerificationResponse = Get-HuduArticles -Id $ArticleId
        $MovedArticle = $VerificationResponse.article
        if (-not $MovedArticle) {
            $MovedArticle = $VerificationResponse
        }

        $MovedCompanyId = if ($MovedArticle -and $null -eq $MovedArticle.company_id) { $null } elseif ($MovedArticle) { [int]$MovedArticle.company_id }
        if (-not $MovedArticle -or $MovedCompanyId -ne $CompanyId) {
            throw "Article $ArticleId did not move to $DestinationDescription."
        }
        if ($null -eq $DestinationFolderId) {
            if ($null -ne $MovedArticle.folder_id) {
                throw "Article $ArticleId moved to $DestinationDescription but folder_id was not cleared."
            }
        } elseif ([int]$MovedArticle.folder_id -ne $DestinationFolderId) {
            throw "Article $ArticleId moved to $DestinationDescription but not to folder $DestinationFolderId."
        }

        if ($null -ne $Result) {
            $Result
        } else {
            $MovedArticle
        }
    }
}
