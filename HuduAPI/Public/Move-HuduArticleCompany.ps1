function Move-HuduArticleCompany {
    <#
    .SYNOPSIS
    Move a Knowledge Base Article to a different company or the central Knowledge Base

    .DESCRIPTION
    Uses Hudu API to update an article's company_id via PUT /api/v1/articles/{id}.

    Pass a company id to move the article onto that company's Knowledge Base.
    Pass $null for -CompanyId to move the article into the central (global) Knowledge Base.

    .PARAMETER HuduBaseURL
    Optional Hudu base URL. When provided, it is applied with New-HuduBaseURL before the request.

    .PARAMETER ArticleId
    Id of the article to move

    .PARAMETER CompanyId
    Destination company id, or $null to move the article into the central Knowledge Base

    .PARAMETER FolderId
When FolderId is omitted, or passed as $null, the article is moved to the root of the destination
Knowledge Base (company or central). When a folder id is supplied, the folder must belong
to the same destination as CompanyId.

    .EXAMPLE
    Move-HuduArticleCompany -ArticleId 1 -CompanyId 20

    .EXAMPLE
    Move-HuduArticleCompany -ArticleId 1 -CompanyId $null

    .EXAMPLE
    Move-HuduArticleCompany -HuduBaseURL https://demo.huducloud.com -ArticleId 1 -CompanyId 20

    .EXAMPLE
    Move-HuduArticleCompany -ArticleId 1 -CompanyId 20 -FolderId 5
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter()]
        [Alias('BaseURL')]
        [String]$HuduBaseURL,

        [Alias('article_id', 'id')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$ArticleId,

        [Alias('company_id')]
        [Parameter(Mandatory = $true)]
        [AllowNull()]
        [Nullable[int]]$CompanyId,

        [Alias('folder_id')]
        [AllowNull()]
        [Nullable[int]]$FolderId
    )

    if ($HuduBaseURL) {
        New-HuduBaseURL -BaseURL $HuduBaseURL
    }

    if ($null -ne $CompanyId -and $CompanyId -lt 1) {
        throw 'CompanyId must be $null for the central Knowledge Base, or an integer greater than or equal to 1.'
    }

    if ($null -ne $FolderId -and $FolderId -lt 1) {
        throw 'FolderId must be $null to clear the folder, or an integer greater than or equal to 1.'
    }

    $DestinationFolderId = $null
    if ($PSBoundParameters.ContainsKey('FolderId') -and $null -ne $FolderId) {
        $Folder = Get-HuduFolders -Id $FolderId
        if (-not $Folder) {
            throw "Destination folder $FolderId could not be found."
        }

        $FolderCompanyId = $Folder.company_id
        if ($null -eq $CompanyId) {
            if ($null -ne $FolderCompanyId) {
                throw "Destination folder $FolderId does not belong to the central Knowledge Base."
            }
        } elseif ($null -eq $FolderCompanyId -or [int]$FolderCompanyId -ne [int]$CompanyId) {
            throw "Destination folder $FolderId does not belong to company $CompanyId."
        }

        $DestinationFolderId = $FolderId
    }

    # Hudu rejects a company change while folder_id still references a folder
    # owned by the source company (or a company folder when moving to central).
    # Explicitly clear it unless a validated destination folder was supplied.
    $Article = [ordered]@{
        article = [ordered]@{
            company_id = $CompanyId
            folder_id  = $DestinationFolderId
        }
    }
    $JSON = $Article | ConvertTo-Json -Depth 10

    $TargetDescription = if ($null -eq $CompanyId) {
        'the central Knowledge Base'
    } else {
        "company $CompanyId"
    }

    if ($PSCmdlet.ShouldProcess("Article ID: $ArticleId", "Move to $TargetDescription")) {
        $Result = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$ArticleId" -Body $JSON

        # Invoke-HuduRequest returns $null after a failed retry, so verify the
        # persisted state instead of silently reporting a successful move.
        $VerificationResponse = Get-HuduArticles -Id $ArticleId
        $MovedArticle = $VerificationResponse.article
        if (-not $MovedArticle) {
            $MovedArticle = $VerificationResponse
        }

        if (-not $MovedArticle) {
            throw "Article $ArticleId could not be verified after the move."
        }

        $MovedCompanyId = $MovedArticle.company_id
        if ($null -eq $CompanyId) {
            if ($null -ne $MovedCompanyId) {
                throw "Article $ArticleId did not move to the central Knowledge Base."
            }
        } elseif ($null -eq $MovedCompanyId -or [int]$MovedCompanyId -ne [int]$CompanyId) {
            throw "Article $ArticleId did not move to company $CompanyId."
        }

        if ($null -eq $DestinationFolderId) {
            if ($null -ne $MovedArticle.folder_id) {
                throw "Article $ArticleId moved to $TargetDescription but folder_id was not cleared."
            }
        } elseif ([int]$MovedArticle.folder_id -ne [int]$DestinationFolderId) {
            throw "Article $ArticleId moved to $TargetDescription but not to folder $DestinationFolderId."
        }

        if ($null -ne $Result) {
            $Result
        } else {
            $MovedArticle
        }
    }
}
