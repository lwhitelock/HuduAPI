function New-HuduIPAddress {
<#
.SYNOPSIS
Create a new Hudu IP address.

.DESCRIPTION
Creates a Hudu IPAM IP address record within a specific Company and Network.
Returns the created IP address object on success, or $null on failure.

.PARAMETER Address
The IP address to create (required). Example: '192.168.10.15'.

.PARAMETER NetworkId
Parent Network ID to associate with (required).

.PARAMETER CompanyId
Company ID to associate with (required).

.PARAMETER Status
IP status string as used by Hudu (e.g. 'active', 'reserved', 'available').

.PARAMETER FQDN
Optional FQDN for this IP.

.PARAMETER Description
Free-form description for the IP record.

.PARAMETER Notes
Free-form notes for the IP record.

.PARAMETER AssetId
Related Asset ID to link this IP to.

.PARAMETER SkipDNSValidation
If $true, the server should skip DNS validation for FQDN (default: $true). [note- DNS validation only works if your hudu instance can resolve dns to this address, so public or same-private network]

.OUTPUTS
pscustomobject (the created IP address object) or $null on failure.

.EXAMPLE
New-HuduIPAddress -Address '10.20.30.15' -CompanyId 42 -NetworkId 7 -Status reserved

.EXAMPLE
New-HuduIPAddress -Address '172.16.0.10' -CompanyId 42 -NetworkId 7 -FQDN 'printer01.example.com' -Description 'Front office printer'

.NOTES
Status is passed through as provided; the module lowercases certain fields as needed by the API.
SkipDNSValidation is sent as a lowercased string value ('true'/'false') per API expectations.
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
        [bool]$SkipDNSValidation=$true
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
