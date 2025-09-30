function Set-HuduVLANZone {
<#
.SYNOPSIS
Update an existing VLAN Zone.

.DESCRIPTION
Modifies VLAN Zone properties such as company, description, VLAN Id ranges, or archival status.

.PARAMETER Id
The Id of the VLAN Zone to update.

.PARAMETER CompanyId
Company identifier (optional override).

.PARAMETER Description
Update the description text.

.PARAMETER VLANIdRanges
New VLAN ranges string (e.g. "100-200,300-350").

.PARAMETER Archived
Set archival status: "true" or "false".

.EXAMPLE
Set-HuduVLANZone -Id 5 -Description "Updated description" -Archived "false"

#>`    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [int]$CompanyId,
        [string]$Description,
        # VLAN ranges: "1-4", "200-300,400-450", etc.
        [ValidatePattern('^([1-9][0-9]{0,3}-[1-9][0-9]{0,3})(,([1-9][0-9]{0,3}-[1-9][0-9]{0,3}))*$')]
        [string]$VLANIdRanges,
        [ValidateSet("true","false")][string]$Archived
    )
    $vlan_zone = Get-HuduVLANZones -id $Id
    if ($Archived) {
        $vlan_zone | Add-Member -MemberType NoteProperty -Name archived -Force -Value $Archived
    }
    if ($VLANIdRanges) {
        $vlan_zone | Add-Member -MemberType NoteProperty -Name vlan_id_ranges -Force -Value $VLANIdRanges
    }
    if ($Description) {
        $vlan_zone | Add-Member -MemberType NoteProperty -Name description -Force -Value $Description
    }
    if ($CompanyId) {
        $vlan_zone | Add-Member -MemberType NoteProperty -Name company_id -Force -Value $CompanyId
    }
        


    $payload = @{
        vlan_zone = $vlan_zone
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method PUT -Resource "/api/v1/vlan_zones/$Id" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to archive vlan zone ID $Id"
        return $null
    }
}
