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
        [string]$Description='',
        [string]$Notes='',
        [int]$AssetID,
        [bool]$SkipDNSValidation=$false
    )
    if (@($Address, $CompanyId, $NetworkId) -contains $null) {
        Write-Warning "Missing required item(s)"
        return $null
    }
    $newaddress= @{
        address         = $Address
        company_id      = $CompanyId
        network_id      = $NetworkId
    }

    if ($Status){
        $newaddress["status"]=$Status
    }    
    if ($FQDN){
        $newaddress["fqdn"]=$FQDN
    }
    if ($Description){
        $newaddress["description"]=$description
    }
    if ($Notes){
        $newaddress["notes"]=$Notes
    }    
    if ($AssetId){
        $newaddress["asset_id"]=$AssetId
    }   
    if ($SkipDNSValidation){
        $newaddress["skip_dns_validation"]="$($SkipDNSValidation)".ToLower()
    } else {
        $newaddress["skip_dns_validation"]="true"
    }

    $payload = $newaddress | ConvertTo-Json -depth 10
    try {
        $response = Invoke-HuduRequest -Method POST -Resource "/api/v1/ip_addresses" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to create address '$Name'"
        return $null
    }
}
