function Get-HuduRelations {
    <#
    .SYNOPSIS
    Get a list of relations.

    .DESCRIPTION
    Calls the Hudu API to retrieve object relationships with optional filtering.

    .PARAMETER FromableType
    Filter by the FROM record type.

    .PARAMETER FromableId
    Filter by the FROM record ID.

    .PARAMETER ToableType
    Filter by the TO record type.

    .PARAMETER ToableId
    Filter by the TO record ID.

    .PARAMETER IsInverse
    Filter by whether the relation is the inverse side.

    .PARAMETER Description
    Filter by description.

    .PARAMETER CreatedAt
    Filter by creation date using the raw API value (YYYY-MM-DD, ISO datetime, or API-supported range string).

    .PARAMETER CreatedAfter
    Start datetime for the created_at range.

    .PARAMETER CreatedBefore
    End datetime for the created_at range.

    .PARAMETER UpdatedAt
    Filter by update date using the raw API value (YYYY-MM-DD, ISO datetime, or API-supported range string).

    .PARAMETER UpdatedAfter
    Start datetime for the updated_at range.

    .PARAMETER UpdatedBefore
    End datetime for the updated_at range.

    .PARAMETER Page
    Return a specific page instead of auto-paginating all results.

    .PARAMETER PageSize
    Number of results per page. Defaults to 1000 when auto-paginating.

    .EXAMPLE
    Get-HuduRelations -FromableType Asset -FromableId 123

    .EXAMPLE
    Get-HuduRelations -ToableType Company -ToableId 42 -IsInverse $false

    .EXAMPLE
    Get-HuduRelations -CreatedAfter ([datetime]'2026-08-01') -UpdatedBefore ([datetime]'2026-08-07')

    #>
    [CmdletBinding()]
    Param(
        [Alias('fromable_type')]
        [ValidateScript({ Assert-AllowedObjectType -InputType $_ -AllowedCanonicals @(
            'Asset', 'Website', 'Procedure', 'AssetPassword', 'Company', 'Article', 'Network', 'IpAddress', 'Vlan', 'VlanZone', 'RackStorage'
        ) })]
        [string]$FromableType,

        [Alias('fromable_id')]
        [int]$FromableId,

        [Alias('toable_type')]
        [ValidateScript({ Assert-AllowedObjectType -InputType $_ -AllowedCanonicals @(
            'Asset', 'Website', 'Procedure', 'AssetPassword', 'Company', 'Article', 'Network', 'IpAddress', 'Vlan', 'VlanZone', 'RackStorage'
        ) })]
        [string]$ToableType,

        [Alias('toable_id')]
        [int]$ToableId,

        [Alias('is_inverse')]
        [bool]$IsInverse,

        [string]$Description,

        [Alias('created_at')]
        [string]$CreatedAt,

        [datetime]$CreatedAfter,
        [datetime]$CreatedBefore,

        [Alias('updated_at')]
        [string]$UpdatedAt,

        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$Page,

        [Alias('page_size')]
        [ValidateRange(1, 1000)]
        [int]$PageSize = 1000
    )

    if ($PSBoundParameters.ContainsKey('CreatedAt') -and ($PSBoundParameters.ContainsKey('CreatedAfter') -or $PSBoundParameters.ContainsKey('CreatedBefore'))) {
        throw "Use either -CreatedAt or -CreatedAfter/-CreatedBefore, not both."
    }

    if ($PSBoundParameters.ContainsKey('UpdatedAt') -and ($PSBoundParameters.ContainsKey('UpdatedAfter') -or $PSBoundParameters.ContainsKey('UpdatedBefore'))) {
        throw "Use either -UpdatedAt or -UpdatedAfter/-UpdatedBefore, not both."
    }

    $params = @{}

    if ($PSBoundParameters.ContainsKey('FromableType')) { $params.fromable_type = Get-ObjectTypeFromCononical -inputData $FromableType }
    if ($PSBoundParameters.ContainsKey('FromableId'))   { $params.fromable_id   = $FromableId }
    if ($PSBoundParameters.ContainsKey('ToableType'))   { $params.toable_type   = Get-ObjectTypeFromCononical -inputData $ToableType }
    if ($PSBoundParameters.ContainsKey('ToableId'))     { $params.toable_id     = $ToableId }
    if ($PSBoundParameters.ContainsKey('IsInverse'))    { $params.is_inverse    = $IsInverse.ToString().ToLowerInvariant() }
    if ($PSBoundParameters.ContainsKey('Description'))  { $params.description   = $Description }
    if ($PSBoundParameters.ContainsKey('CreatedAt'))    { $params.created_at    = $CreatedAt }
    if ($PSBoundParameters.ContainsKey('UpdatedAt'))    { $params.updated_at    = $UpdatedAt }

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($null -ne $createdRange) {
        $params.created_at = $createdRange
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($null -ne $updatedRange) {
        $params.updated_at = $updatedRange
    }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/relations'
        Params   = $params
    }

    if ($PSBoundParameters.ContainsKey('Page')) {
        $params.page = $Page
        $params.page_size = $PageSize
        $response = Invoke-HuduRequest @HuduRequest
        return ($response.relations ?? $response)
    }

    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'relations' -PageSize $PageSize
}
