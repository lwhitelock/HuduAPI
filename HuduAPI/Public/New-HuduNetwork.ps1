function New-HuduNetwork {
<#
.SYNOPSIS
Create a new Hudu network.

.DESCRIPTION
Creates a new hudu IPAM Network Object for a Company.
Name, Address (or CIDR Address Range) and CompanyId are required.
Returns the created network object on success, or $null on failure.

.PARAMETER Name
Display name for the network. (Required)

.PARAMETER Address
CIDR notation for the network (e.g. 10.0.0.0/24). (Required)

.PARAMETER CompanyId
Company ID to associate with the network. (Required)

.PARAMETER LocationId
Optional location ID to associate with the network.

.PARAMETER Description
Free-form description of the network.

.PARAMETER NetworkType
Numeric network type as used by Hudu (module/API enum value).

.PARAMETER VlanId
VLAN identifier for the network.

.EXAMPLE
New-HuduNetwork -Name "Core LAN" -Address "192.168.10.0/24" -CompanyId 42

.EXAMPLE
New-HuduNetwork -Name "Server VLAN 30" -Address "10.20.30.0/24" -CompanyId 42 -LocationId 7 -VlanId 30 -NetworkType 1
#>    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string]$Address,
        [Parameter(Mandatory)]
        [int]$CompanyId,
        [int]$LocationId,
        [string]$Description,
        [int]$NetworkType,
        [int]$VlanId
    )
    if (@($Name, $Address, $CompanyId) -contains $null) {
        Write-Warning "Missing required item."
        return $null
    }


    $network= @{
        name            = $Name
        address         = $Address
        company_id      = $CompanyId
    }
    if ($Description){
        $network["description"]=$description
    }
    if ($networkType){
        $network["network_type"]=$networkType
    }
    if ($LocationId){
        $network["location_id"]=$LocationId
    }
    if ($vlanId){
        $network["vlan_id"]=$vlanId
    }


    $payload = $network | ConvertTo-Json -depth 10
    try {
        $response = Invoke-HuduRequest -Method POST -Resource "/api/v1/networks" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to create network '$Name'"
        return $null
    }
}
