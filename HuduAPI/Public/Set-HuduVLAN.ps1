function Set-HuduVLAN {
<#
.SYNOPSIS
Update an existing VLAN.

.DESCRIPTION
Modifies VLAN properties such as name, company association, description, role/status list Ids, 
VLAN Id, VLAN Zone association, or archival status.

.PARAMETER Id
The Id of the VLAN to update.

.PARAMETER Name
New VLAN name.

.PARAMETER CompanyId
Company identifier (optional override).

.PARAMETER Description
Update the description text.

.PARAMETER RoleListItemID
Update the role list item association.

.PARAMETER StatusListItemID
Update the status list item association.

.PARAMETER VLANId
Update the VLAN Id (between 4 and 4094).

.PARAMETER VLANZoneId
Associate with a VLAN Zone.

.PARAMETER Archived
Set archival status: "true" or "false".

.EXAMPLE
Set-HuduVLAN -Id 7 -Description "Changed purpose" -VLANId 250
#>    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [string]$Name,
        [int]$CompanyId,
        [string]$Description,
        [int]$RoleListItemID,
        [int]$StatusListItemID,
        [ValidateRange(4,4094)][int]$VLANId,
        [int]$VLANZoneId,
        [ValidateSet("true","false")][string]$Archived
    )
    $vlan = Get-HuduVLANs -id $Id
    if ($Name) {
        $vlan | Add-Member -MemberType NoteProperty -Name name -Force -Value $Name
    }
    if ($CompanyId) {
        $vlan | Add-Member -MemberType NoteProperty -Name company_id -Force -Value $CompanyId
    }
    if ($Description) {
        $vlan | Add-Member -MemberType NoteProperty -Name description -Force -Value $Description
    }
    if ($RoleListItemID) {
        $vlan | Add-Member -MemberType NoteProperty -Name role_list_item_id -Force -Value $RoleListItemID
    }
    if ($StatusListItemID) {
        $vlan | Add-Member -MemberType NoteProperty -Name status_list_item_id -Force -Value $StatusListItemID
    }            
    if ($VLANId) {
        $vlan | Add-Member -MemberType NoteProperty -Name vlan_id -Force -Value $VLANId
    }
    if ($VLANZoneId) {
        $vlan | Add-Member -MemberType NoteProperty -Name vlan_zone_id -Force -Value $VLANZoneId
    }
    if ($Archived) {
        $vlan | Add-Member -MemberType NoteProperty -Name archived -Force -Value $Archived
    }

    $payload = @{
        vlan             = $vlan
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method PUT -Resource "/api/v1/vlans/$Id" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to vlan ID $Id"
        return $null
    }
}
