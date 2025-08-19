function Set-HuduNetwork {
<#
.SYNOPSIS
Update a Hudu network.

.DESCRIPTION
Updates a Hudu IPAM Network object for a Company.
Returns the updated network object on success, or $null on failure.

.PARAMETER Id
The unique network ID to update. (Required)

.PARAMETER Name
New name for the network.

.PARAMETER Address
CIDR notation for the network (e.g. 192.168.10.0/24).

.PARAMETER CompanyId
Company ID to associate with the network.

.PARAMETER LocationId
Location ID to associate with the network.

.PARAMETER Description
Free-form description of the network.

.PARAMETER NetworkType
Numeric network type as used by Hudu (module/API enum value).

.PARAMETER VlanId
VLAN identifier for the network.

.EXAMPLE
Set-HuduNetwork -Id 123 -Name "Core LAN" -Description "Primary office network"

.EXAMPLE
Set-HuduNetwork -Id 123 -Address "10.20.30.0/24" -VlanId 30 -LocationId 456
#>    

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id,
        [string]$Name,
        [string]$Address,
        [int]$CompanyId,
        [int]$LocationId,
        [string]$Description,
        [int]$NetworkType,
        [int]$VlanId
    )
    $object = Get-HuduNetworks -id $Id
    $hudunetwork = [ordered]@{network = $object }

    if ($Name) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name name -Force -Value $Name
    }
    if ($Address) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name address -Force -Value $Address
    }
    if ($CompanyId) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name company_id -Force -Value $CompanyId
    }
    if ($LocationId) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name location_id -Force -Value $LocationId
    }
    if ($Description) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name description -Force -Value $Description
    }
    if ($NetworkType) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name network_type -Force -Value $NetworkType
    }
    if ($VlanId) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name vlan_id -Force -Value $VlanId
    }
 


    $payload = $hudunetwork | ConvertTo-Json -depth 10
    try {
        $response = Invoke-HuduRequest -Method PUT -Resource "/api/v1/networks/$Id" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to set network '$Id'"
        return $null
    }
}