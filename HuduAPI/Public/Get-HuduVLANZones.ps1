function Get-HuduVLANZones {
    [CmdletBinding()]
    param(
        [int]$CompanyId,
        [string]$Name,
        [string]$Archived,
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

    Invoke-HuduRequest -HuduRequest @{
        Method   = 'GET'
        Resource = '/api/v1/vlan_zones'
        Params   = $params
    } -Property vlan_zones
}
