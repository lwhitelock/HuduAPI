function New-HuduNetwork {
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
