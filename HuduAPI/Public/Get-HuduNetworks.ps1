

function Get-HuduNetworks {
<#
.SYNOPSIS
Retrieve Hudu network by ID or networks.

.DESCRIPTION
Gets a single network by ID, or lists networks filtered by one or more criteria.
When -Id is provided, performs GET /api/v1/networks/{id}. Otherwise performs
GET /api/v1/networks with query parameters built from the provided filters.
Supports created/updated date range filtering via Convert-ToHuduDateRange.

.PARAMETER Id
Network ID. When supplied, returns only that network.

.PARAMETER CompanyId
Filter by company ID.

.PARAMETER Slug
Filter by slug.

.PARAMETER Name
Filter by network name (exact match as supported by the API).

.PARAMETER NetworkType
Filter by numeric network type.

.PARAMETER Address
Filter by CIDR/address string.

.PARAMETER LocationId
Filter by location ID.

.PARAMETER Archived
Filter archived state (True/False).

.PARAMETER CreatedAfter
Only include networks created on or after this date/time.

.PARAMETER CreatedBefore
Only include networks created on or before this date/time.

.PARAMETER UpdatedAfter
Only include networks updated on or after this date/time.

.PARAMETER UpdatedBefore
Only include networks updated on or before this date/time.

.EXAMPLE
Get-HuduNetworks -Id 123

.EXAMPLE
Get-HuduNetworks -CompanyId 42 -LocationId 7 -Archived $false

.EXAMPLE
Get-HuduNetworks -CreatedAfter ([datetime]'2025-08-01') -UpdatedBefore ([datetime]'2025-08-15')
#>
    [CmdletBinding()]
    param (
        [int]$Id,
        [int]$CompanyId,
        [string]$Slug,
        [string]$Name,
        [int]$NetworkType,
        [string]$Address,
        [int]$LocationID,
        [bool]$Archived,
        [datetime]$CreatedAfter,
        [datetime]$CreatedBefore,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore
    )

    $BaseResource = "/api/v1/networks"

    $Params = @{}
    if ($CompanyId) { $Params["company_id"] = $CompanyId }
    if ($Slug) { $Params["slug"] = $Slug }
    if ($Name) { $Params["name"] = $Name }
    if ($NetworkType) { $Params["network_type"] = $NetworkType }
    if ($Address) { $Params["address"] = $Address }
    if ($LocationID) { $Params["location_id"] = $LocationID }
    if ($Archived) { $Params["archived"] = $Archived }

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($createdRange -ne ',' -and -$null -ne $createdRange) {
        $Params.created_at = $createdRange
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
        $Params.updated_at = $updatedRange
    }
    
    $HuduRequest = if ($Id) {
        @{
            Method   = 'GET'
            Resource = "$BaseResource/$Id"
        }
    } else {
        @{
            Method   = 'GET'
            Resource = "$BaseResource"
            Params   = if ($Params.Count -gt 0) { $Params } else { $null }
        }
    }

    Invoke-HuduRequest @HuduRequest
}
