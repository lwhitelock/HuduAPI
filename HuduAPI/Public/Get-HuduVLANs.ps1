function Get-HuduVLANs {
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
