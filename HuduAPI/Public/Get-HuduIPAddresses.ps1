function Get-HuduIPAddresses {
<#
.SYNOPSIS
Retrieve Hudu IP address records.

.DESCRIPTION
Gets one or more Hudu IPAM IP address objects.  
If -Id is supplied, returns a single record (or $null if not found).  
Without -Id, applies any provided filters and returns a collection.

.PARAMETER Id
IP address record ID to retrieve (exact match).

.PARAMETER Address
IP address (exact string match, e.g. '192.168.10.15').

.PARAMETER Status
IP status string as used by Hudu (e.g. 'active', 'reserved', 'available').
Value is lowercased before request.

.PARAMETER FQDN
Fully Qualified Domain Name to filter on (exact match).

.PARAMETER AssetId
Filter by related Asset ID.

.PARAMETER NetworkId
Filter by parent Network ID.

.PARAMETER CompanyId
Filter by Company ID.

.PARAMETER CreatedAfter
Only include IPs created on/after this UTC datetime.

.PARAMETER CreatedBefore
Only include IPs created on/before this UTC datetime.

.PARAMETER UpdatedAfter
Only include IPs updated on/after this UTC datetime.

.PARAMETER UpdatedBefore
Only include IPs updated on/before this UTC datetime.

.OUTPUTS
pscustomobject (single object when -Id is used) or an array of pscustomobject.

.EXAMPLE
Get-HuduIPAddresses -Id 1234

.EXAMPLE
Get-HuduIPAddresses -CompanyId 42 -NetworkId 7 -Status reserved

.EXAMPLE
# Filter by date range (created)
Get-HuduIPAddresses -CreatedAfter (Get-Date).AddDays(-7) -CreatedBefore (Get-Date)

.NOTES
Created*/Updated* pairs are converted to the API’s 'start,end' format via Convert-ToHuduDateRange.
If no filters are passed (and no -Id), all IPs are requested (server-side limits may apply).
#>
    [CmdletBinding()]
    param(
        [int]$Id,
        [string]$Address,
        [string]$Status,
        [string]$FQDN,
        [int]$AssetID,
        [int]$CompanyID,
        [datetime]$CreatedAfter,
        [datetime]$CreatedBefore,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore        
    )
    $Params = @{}
    if ($NetworkId){$params["network_id"]=$NetworkId}
    if ($Address){$params["address"]=$Address}
    if ($Status){$params["status"]="$Status".ToLower()}
    if ($FQDN){$params["fqdn"]=$FQDN}
    if ($AssetID){$params["asset_id"]=$AssetID}
    if ($CompanyID){$params["company_id"]=$CompanyID}

    $createdRange = if ($CreatedAfter -and $CreatedBefore) {Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore}
    if ($createdRange -ne ',' -and -$null -ne $createdRange) {
        $Params.created_at = $createdRange
    }

    $updatedRange = if ($UpdatedAfter -and $UpdatedBefore) {Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore}
    if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
        $Params.updated_at = $updatedRange
    }
    $HuduRequest = if ($Id) {
        @{
            Method   = 'GET'
            Resource = "/api/v1/ip_addresses/$Id"
        }
    } else {
        @{
            Method   = 'GET'
            Resource = "/api/v1/ip_addresses"
            Params   = if ($Params.Count -gt 0) { $Params } else { $null }
        }
    }

    $addresses = Invoke-HuduRequest @HuduRequest

    return $addresses
}
