function Get-HuduLabelTypes {
<#
.SYNOPSIS
Gets Label Types from Hudu.

.DESCRIPTION
Retrieves Label Types by ID or lists Label Types with optional filtering. When
listing, filters match exact values for name/color/slug when provided.

.PARAMETER Id
Return a single Label Type by ID.

.PARAMETER Name
Filter by exact Label Type name.

.PARAMETER Color
Filter by exact color value, such as #0000ff.

.PARAMETER Slug
Filter by exact slug value.

.PARAMETER CreatedAt
Filter by creation date (YYYY-MM-DD or ISO datetime).

.PARAMETER UpdatedAt
Filter by update date (YYYY-MM-DD or ISO datetime).

.PARAMETER Page
Return a specific page instead of auto-paginating all results.

.PARAMETER PageSize
Number of results per page. Defaults to 1000 when auto-paginating.

.EXAMPLE
Get-HuduLabelTypes

.EXAMPLE
Get-HuduLabelTypes -Name "Critical"

.EXAMPLE
Get-HuduLabelTypes -Id 12

.NOTES
API Endpoints:
- GET /api/v1/label_types
- GET /api/v1/label_types/{id}
#>

    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById')]
        [Alias('LabelTypeId','label_type_id')]
        [int]$Id,

        [Parameter(ParameterSetName = 'List')]
        [string]$Name,

        [Parameter(ParameterSetName = 'List')]
        [ValidateNotNullOrEmpty()]
        [string]$Color,

        [Parameter(ParameterSetName = 'List')]
        [string]$Slug,

        [Parameter(ParameterSetName = 'List')]
        [string]$CreatedAt,

        [Parameter(ParameterSetName = 'List')]
        [string]$UpdatedAt,

        [Parameter(ParameterSetName = 'List')]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Page,

        [Parameter(ParameterSetName = 'List')]
        [ValidateRange(1, 1000)]
        [int]$PageSize = 1000
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            $resp = Invoke-HuduRequest -Method GET -Resource "/api/v1/label_types/$Id"
            return ($resp.label_type ?? $resp)
        }

        $params = @{}
        if ($PSBoundParameters.ContainsKey('Name'))      { $params.name       = $Name }
        if ($PSBoundParameters.ContainsKey('Color'))     { $params.color      = $Color }
        if ($PSBoundParameters.ContainsKey('Slug'))      { $params.slug       = $Slug }
        if ($PSBoundParameters.ContainsKey('CreatedAt')) { $params.created_at = $CreatedAt }
        if ($PSBoundParameters.ContainsKey('UpdatedAt')) { $params.updated_at = $UpdatedAt }

        $req = @{
            Method   = 'GET'
            Resource = "/api/v1/label_types"
            Params   = $params
        }

        if ($PSBoundParameters.ContainsKey('Page')) {
            $params.page = $Page
            $params.page_size = $PageSize
            $resp = Invoke-HuduRequest @req
            return ($resp.label_types ?? $resp)
        }

        Invoke-HuduRequestPaginated -HuduRequest $req -Property 'label_types' -PageSize $PageSize
    }
}
