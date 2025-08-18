function Set-HuduNetwork {
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
        [int]$VlanId,
        [bool]$Archived
    )
    $network = Get-HuduNetworks -id $Id
    if ($Name) {
        $network.name = $name
    }
    if ($Address) {
        $network.address = $Address
    }
    if ($CompanyId) {
        $network.company_id = $CompanyId
    }
    if ($LocationId) {
        $network.location_id = $LocationId
    }
    if ($Description) {
        $network.description = $Description
    }
    if ($NetworkType) {
        $network.network_type = $NetworkType
    }
    if ($VlanId) {
        $network.vlan_id = $VlanId
    }
    if ($Archived) {
        $network.archived = $Archived
    }        


    $payload = @{network = $network} | ConvertTo-Json -depth 10
    try {
        $response = Invoke-HuduRequest -Method PUT -Resource "/api/v1/networks/$Id" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to create network '$Name'"
        return $null
    }
}
