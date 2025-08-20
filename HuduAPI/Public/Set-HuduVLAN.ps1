function Set-HuduVLAN {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [string]$Name,
        [int]$CompanyId,
        [string]$Description,
        [int]$RoleListItemID,
        [int]$StatusListItemID,
        [int]$VLANId,
        [int]$VLANZoneId,
        [string]$Archived='false',
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
        return $res.procedure
    } catch {
        Write-Warning "Failed to vlan ID $Id"
        return $null
    }
}
