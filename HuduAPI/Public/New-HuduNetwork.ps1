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
        [int]$VlanId,
        [bool]$Archived=$false
    )
    if (@($Name, $Address, $CompanyId) -contains $null) {
        Write-Warning "Missing required item."
        return $null
    }


    $network= @{
        Name            = $Name
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
    if ($Archived){
        $network["archived"]=$Archived
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
