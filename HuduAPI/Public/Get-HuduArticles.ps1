function Get-HuduArticles {
    <#
    .SYNOPSIS
    Get Knowledge Base Articles

    .DESCRIPTION
    Calls Hudu API to retrieve KB articles by Id or a list

    .PARAMETER Id
    Id of the Article

    .PARAMETER CompanyId
    Filter by company id

    .PARAMETER Name
    Filter by name of article

    .PARAMETER Slug
    Filter by slug of article

    .PARAMETER Search
    Filter by search terms

    .PARAMETER Draft
    Filter by draft status

    .PARAMETER Public
    Filter by public status

    .PARAMETER StartDate
    Filter by updated_at property

    .PARAMETER EndDate
    Filter by updated_at property

    .PARAMETER ExactDate
    Filter by updated_at property

    .EXAMPLE
    Get-HuduArticles -Name 'Article name'

    .NOTES

    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    Param (
        [Parameter(ParameterSetName = 'Single')]
        [Int]$Id = '',

        [Parameter(ParameterSetName = 'List')]
        [Alias('company_id')]
        [Int]$CompanyId = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$Name = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$Slug,

        [Parameter(ParameterSetName = 'List')]
        [String]$Search,

        [Parameter(ParameterSetName = 'List')]
        [Switch]$Draft,

        [Parameter(ParameterSetName = 'List')]
        [Switch]$Public,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$StartDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$EndDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$ExactDate
    )

    if ($Id) {
        Invoke-HuduRequest -Method get -Resource "/api/v1/articles/$Id"
    } else {
        $Params = @{}

        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($Name) { $Params.name = $Name }
        if ($Slug) { $Params.slug = $Slug }
        if ($Search) { $Params.search = $Search }
        if ($Draft.IsPresent) { $Params.draft = $Draft.IsPresent }
        if ($Public.IsPresent) { $Params.enable_sharing = $Public.IsPresent }

        if ($StartDate) {
            $ISO8601StartDate = $StartDate.ToString('o');
        } else {
            $ISO8601StartDate = ''
        }

        if ($EndDate) {
            $ISO8601EndDate = $EndDate.ToString('o');
        } else {
            $ISO8601EndDate = ''
        }

        if (![String]::IsNullOrEmpty($StartDate) -or ![String]::IsNullOrEmpty($EndDate)) {
            $Params.updated_at = '{0},{1}' -f $ISO8601StartDate, $ISO8601EndDate
        } elseif ($ExactDate) {
            $Params.updated_at = $ExactDate.ToString('o')
        }

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/articles'
            Params   = $Params
        }

        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property articles
    }
}
