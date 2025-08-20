function New-HuduVLANZone {
<#
.SYNOPSIS
Create a new VLAN Zone in Hudu.

.DESCRIPTION
Creates a VLAN Zone under a specified company, with VLAN Id ranges and optional description. 
VLAN ranges must be expressed as "start-end" and may be comma-separated.

.PARAMETER Name
The name of the VLAN Zone.

.PARAMETER CompanyId
The company identifier to associate with this VLAN Zone.

.PARAMETER VLANIdRanges
VLAN Id ranges string (e.g. "1-4", "200-300,400-450").

.PARAMETER Description
Optional description text.

.PARAMETER Archived
Whether the VLAN Zone should be archived upon creation ("true"/"false"). Defaults to "false".

.EXAMPLE
New-HuduVLANZone -Name "East Coast Zone" -CompanyId 1 -VLANIdRanges "200-300" -Description "Datacenter VLANs"
#>    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [int]$CompanyId,
        # VLAN ranges: "1-4", "200-300,400-450", etc.
        [ValidatePattern('^([1-9][0-9]{0,3}-[1-9][0-9]{0,3})(,([1-9][0-9]{0,3}-[1-9][0-9]{0,3}))*$')]
        [string]$VLANIdRanges,
        [string]$Description,
        [ValidateSet("true","false")][string]$Archived='false'
    )

    $vlan_zone = @{name=$Name; company_id = $CompanyId}
    if ($Description) {
        $vlan_zone['description']=$Description
    }
    if ($VLANIdRanges) {
        $vlan_zone['vlan_id_ranges']=$VLANIdRanges
    }
    if ($Archived) {
        $vlan_zone['archived']=$Archived
    }
   
    $payload = @{
        vlan_zone = $vlan_zone
    } | ConvertTo-Json -Depth 10
    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/vlan_zones" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to create vlan zone '$Name'"
        return $null
    }
}
