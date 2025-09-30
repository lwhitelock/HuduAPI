function Get-HuduVLANZones {
<#
.SYNOPSIS
Retrieve VLAN Zone records from Hudu.

.DESCRIPTION
Queries the Hudu API for VLAN Zones. Can filter by Id, CompanyId, Name, VLAN ranges, or archival status, 
as well as created/updated date ranges.

.PARAMETER Id
Specific VLAN Zone Id.

.PARAMETER CompanyId
Filter by company identifier.

.PARAMETER Name
Filter by name (string match).

.PARAMETER Archived
Filter by archival status: "true" or "false".

.PARAMETER VLANIdRanges
Filter by VLAN Id ranges (e.g. "1-4", "200-300,400-450").

.PARAMETER CreatedAfter
Return only VLAN Zones created after this date/time.

.PARAMETER CreatedBefore
Return only VLAN Zones created before this date/time.

.PARAMETER UpdatedAfter
Return only VLAN Zones updated after this date/time.

.PARAMETER UpdatedBefore
Return only VLAN Zones updated before this date/time.

.EXAMPLE
Get-HuduVLANZones -CompanyId 5 -Archived "false"
#>    
    [CmdletBinding()]
    param(
        [int]$Id,
        [int]$CompanyId,
        [string]$Name,
        [string]$Archived,
        # VLAN ranges: "1-4", "200-300,400-450", etc.
        [ValidatePattern('^([1-9][0-9]{0,3}-[1-9][0-9]{0,3})(,([1-9][0-9]{0,3}-[1-9][0-9]{0,3}))*$')]
        [string]$VLANIdRanges,
        [datetime]$CreatedAfter,
        [datetime]$CreatedBefore,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore        
    )

    if ($Id) {
        try {
            $res = Invoke-HuduRequest -Method GET -Resource "/api/v1/vlan_zones/$Id"
            return $res
        } catch {
            Write-Warning "Failed to retrieve vlan zone ID $Id"
            return $null
        }
    }

    $params = @{}
    if ($CompanyId)         { $params.company_id   = $CompanyId }
    if ($Name)              { $params.name         = $Name }
    if ($Archived)          { $params.archived     = $Archived }

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($createdRange -ne ',' -and -$null -ne $createdRange) {
        $params.created_at = $createdRange
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
        $params.updated_at = $updatedRange
    }
    if ($params){
        Invoke-HuduRequest -Method GET -Resource '/api/v1/vlan_zones' -Params $params
    } else {
        Invoke-HuduRequest -Method GET -Resource '/api/v1/vlan_zones'
    }
}
