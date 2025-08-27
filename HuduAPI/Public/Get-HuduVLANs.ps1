function Get-HuduVLANs {
<#
.SYNOPSIS
Retrieve VLAN records from Hudu.

.DESCRIPTION
Queries the Hudu API for VLANs. Supports filtering by Id, VLAN Id, VLAN Zone association, company, slug, 
name, archival status, or creation/update timestamps.

.PARAMETER Id
Specific VLAN Id.

.PARAMETER VLANId
Filter by VLAN Id (must be between 4 and 4094).

.PARAMETER VLANZoneID
Filter by associated VLAN Zone Id.

.PARAMETER CompanyId
Filter by company identifier.

.PARAMETER Slug
Filter by slug value.

.PARAMETER Name
Filter by VLAN name.

.PARAMETER Archived
Filter by archival status: "true" or "false".

.PARAMETER CreatedAfter
Return VLANs created after this date/time.

.PARAMETER CreatedBefore
Return VLANs created before this date/time.

.PARAMETER UpdatedAfter
Return VLANs updated after this date/time.

.PARAMETER UpdatedBefore
Return VLANs updated before this date/time.

.EXAMPLE
Get-HuduVLANs -CompanyId 5 -Archived "false"
#>    
    [CmdletBinding()]
    param(
        [int]$Id,
        [ValidateRange(4,4094)][int]$VLANId,
        [int]$VLANZoneID,
        [int]$CompanyId,
        [string]$Slug,
        [string]$Name,
        [string]$Archived,
        [datetime]$CreatedAfter,
        [datetime]$CreatedBefore,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore        
    )

    if ($Id) {
        try {
            $res = Invoke-HuduRequest -Method GET -Resource "/api/v1/vlans/$Id"
            return $res
        } catch {
            Write-Warning "Failed to retrieve vlan ID $Id"
            return $null
        }
    }

    $params = @{}
    if ($VLANId)            { $params.vlan_id      = $VLANId }
    if ($VLANZoneID)        { $params.vlan_zone_id = $VLANZoneID }
    if ($CompanyId)         { $params.company_id   = $CompanyId }
    if ($Slug)              { $params.slug         = $Slug }
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
    if ($params) {
        Invoke-HuduRequest -Method GET -Resource '/api/v1/vlans' -Params $params
    } else {
        Invoke-HuduRequest -Method GET -Resource "/api/v1/vlans"    
    }
}
