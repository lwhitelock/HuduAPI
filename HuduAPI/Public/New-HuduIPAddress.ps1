function New-HuduIPAddress {
<#
.SYNOPSIS
Create a new Hudu ip address.

#>    
    param(
        [Parameter(Mandatory)]
        [string]$Address,
        [Parameter(Mandatory)]
        [int]$NetworkId,
        [Parameter(Mandatory)]
        [int]$CompanyID,
        [string]$Status,
        [string]$FQDN,
        [string]$Description,
        [string]$Notes,
        [int]$AssetID,
        [bool]$SkipDNSValidation=$false
    )
    if (@($Name, $Address, $CompanyId) -contains $null) {
        Write-Warning "Missing required item."
        return $null
    }
    $address= @{
        address         = $Address
        company_id      = $CompanyId
        network_id      = $NetworkId
    }

    if ($Status){
        $address["status"]=$Status
    }    
    if ($FQDN){
        $address["fqdn"]=$FQDN
    }
    if ($Description){
        $address["description"]=$description
    }
    if ($Notes){
        $address["notes"]=$Notes
    }    
    if ($AssetId){
        $address["asset_id"]=$AssetId
    }    
    if ($SkipDNSValidation){
        $address["skip_dns_validation"]="$($SkipDNSValidation)".ToLower()
    } else {
        $address["asset_id"]="true"
    }

    $payload = $address | ConvertTo-Json -depth 10
    try {
        $response = Invoke-HuduRequest -Method POST -Resource "/api/v1/ip_addresses" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to create address '$Name'"
        return $null
    }
}
