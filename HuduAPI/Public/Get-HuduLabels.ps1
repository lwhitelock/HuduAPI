function Get-HuduLabels {
<#
.SYNOPSIS
Gets Labels from Hudu.

.DESCRIPTION
Retrieves a single Label by ID, or lists Labels with optional filtering by label
type, target record, user, and created/updated dates.

.PARAMETER Id
Return a single Label by ID.

.PARAMETER LabelTypeId
Filter labels by Label Type ID.

.PARAMETER Labelable_Type
Filter by the target object type the label is attached to.

.PARAMETER Labelable_Id
Filter by the target object ID the label is attached to.

.PARAMETER UserId
Filter by the ID of the user who applied the label.

.PARAMETER CreatedAt
Filter by creation date (YYYY-MM-DD or ISO datetime).

.PARAMETER UpdatedAt
Filter by update date (YYYY-MM-DD or ISO datetime).

.PARAMETER Page
Return a specific page instead of auto-paginating all results.

.PARAMETER PageSize
Number of results per page. Defaults to 1000 when auto-paginating.

.EXAMPLE
Get-HuduLabels

.EXAMPLE
Get-HuduLabels -LabelTypeId 5

.EXAMPLE
Get-HuduLabels -Labelable_Type Asset -Labelable_Id 123

.EXAMPLE
Get-HuduLabels -Id 77

.NOTES
API Endpoints:
- GET /api/v1/labels
- GET /api/v1/labels/{id}
#>

    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById')]
        [Alias('LabelId','label_id')]
        [int]$Id,

        [Parameter(ParameterSetName = 'List')]
        [Alias('label_type_id','labeltype_id','label_typeid','label_type','type_id','typeid')]
        [int]$LabelTypeId,

        [Parameter(ParameterSetName = 'List')]
        [Alias('object_type','objectType','target_type','targetType')]
        [ValidateScript({ Assert-AllowedObjectType -InputType $_ -AllowedCanonicals @(
            'Article', 'Asset', 'AssetPassword', 'Website', 'IpAddress', 'Vlan', 'VlanZone', 'Procedure', 'Network', 'RackStorage'
        ) })]
        [string]$Labelable_Type,

        [Parameter(ParameterSetName = 'List')]
        [Alias('object_id','objectID','target_id','targetId')]
        [int]$Labelable_Id,

        [Parameter(ParameterSetName = 'List')]
        [Alias('user_id')]
        [int]$UserId,

        [Parameter(ParameterSetName = 'List')]
        [Alias('created_at')]
        [string]$CreatedAt,

        [Parameter(ParameterSetName = 'List')]
        [Alias('updated_at')]
        [string]$UpdatedAt,

        [Parameter(ParameterSetName = 'List')]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Page,

        [Parameter(ParameterSetName = 'List')]
        [Alias('page_size')]
        [ValidateRange(1, 1000)]
        [int]$PageSize = 1000
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            $resp = Invoke-HuduRequest -Method GET -Resource "/api/v1/labels/$Id"
            return ($resp.label ?? $resp)
        }

        $params = @{}
        if ($PSBoundParameters.ContainsKey('LabelTypeId'))    { $params.label_type_id  = $LabelTypeId }
        if ($PSBoundParameters.ContainsKey('Labelable_Type')) { $params.labelable_type = Get-ObjectTypeFromCononical -inputData $Labelable_Type }
        if ($PSBoundParameters.ContainsKey('Labelable_Id'))   { $params.labelable_id   = $Labelable_Id }
        if ($PSBoundParameters.ContainsKey('UserId'))         { $params.user_id        = $UserId }
        if ($PSBoundParameters.ContainsKey('CreatedAt'))      { $params.created_at     = $CreatedAt }
        if ($PSBoundParameters.ContainsKey('UpdatedAt'))      { $params.updated_at     = $UpdatedAt }

        $req = @{
            Method   = 'GET'
            Resource = "/api/v1/labels"
            Params   = $params
        }

        if ($PSBoundParameters.ContainsKey('Page')) {
            $params.page = $Page
            $params.page_size = $PageSize
            $resp = Invoke-HuduRequest @req
            return ($resp.labels ?? $resp)
        }

        Invoke-HuduRequestPaginated -HuduRequest $req -Property 'labels' -PageSize $PageSize
    }
}
