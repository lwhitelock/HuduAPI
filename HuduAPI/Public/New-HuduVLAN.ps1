function New-HuduVLAN {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [int]$CompanyId,
        [Parameter(Mandatory)][ValidateRange(4,4094)][int]$VLANId,
        [string]$Description,
        [int]$RoleListItemID,
        [int]$StatusListItemID,
        [int]$VLANZoneId,
        [ValidateSet("true","false")][string]$Archived='false'
    )

    $vlan = @{name=$Name; company_id = $CompanyId}
    if ($Description) {
        $vlan['description']=$Description
    }
    if ($RoleListItemID) {
        $vlan['role_list_item_id']=$RoleListItemID
    }
    if ($StatusListItemID) {
        $vlan['status_list_item_id']=$StatusListItemID
    }
    if ($VLANId) {
        $vlan['vlan_id']=$VLANId
    }
    if ($VLANZoneId) {
        $vlan['vlan_zone_id']=$VLANZoneId
    }
    if ($Archived) {
        $vlan['archived']=$Archived
    }
      

    $payload = @{
        vlan = $vlan
    } | ConvertTo-Json -Depth 10
    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/vlans" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to create vlan '$Name'"
        return $null
    }
}
