function New-HuduVLAN {
<#
.SYNOPSIS
Create a new VLAN in Hudu.

.DESCRIPTION
Creates a VLAN under a specified company. Requires a unique VLAN Id (between 4 and 4094).
Optionally associates role, status, or VLAN Zone.

.PARAMETER Name
The name of the VLAN.

.PARAMETER CompanyId
The company identifier to associate with this VLAN.

.PARAMETER VLANId
The numeric VLAN Id (between 4 and 4094).

.PARAMETER Description
Optional description text.

.PARAMETER RoleListItemID
Optional Id of the role list item to associate.

.PARAMETER StatusListItemID
Optional Id of the status list item to associate.

.PARAMETER VLANZoneId
Optional VLAN Zone Id to associate.

.PARAMETER Archived
Whether the VLAN should be archived upon creation ("true"/"false"). Defaults to "false".

.EXAMPLE
New-HuduVLAN -Name "VLAN-200" -CompanyId 1 -VLANId 200 -Description "Internal traffic"
#>    
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
