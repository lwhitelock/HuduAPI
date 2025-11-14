function Set-HuduIPAddress {
<#
.SYNOPSIS
Update a Hudu IP address.

.DESCRIPTION
Updates fields on an existing Hudu IPAM IP address record.
Returns the updated object on success, the existing object if nothing changed, or $null on failure.

.PARAMETER Id
The unique IP record ID to update (required).

.PARAMETER Address
New IP address string (e.g. '192.168.10.25').

.PARAMETER Status
New IP status string as used by Hudu (e.g. 'active', 'reserved', 'available').
Value is lowercased before request.

.PARAMETER FQDN
New FQDN for this IP.

.PARAMETER Description
New description text.

.PARAMETER Notes
New notes text.

.PARAMETER AssetId
Asset ID to (re)link this IP to.

.PARAMETER NetworkId
Parent Network ID to (re)associate with.

.PARAMETER CompanyId
Company ID to (re)associate with.

.PARAMETER SkipDNSValidation
If specified, controls whether the server should skip DNS validation ('true'/'false' sent).
If $true, the server should skip DNS validation for FQDN (default: $true). [note- DNS validation only works if your hudu instance can resolve dns to this address, so public or same-private network]

.OUTPUTS
pscustomobject (updated IP object), the existing object (if no changes), or $null on failure.

.EXAMPLE
Set-HuduIPAddress -Id 1234 -Status active -Notes 'Now assigned to core switch'

.EXAMPLE
# Update multiple fields, preserving existing unset ones
Set-HuduIPAddress -Id 1234 -IncludeExisting -FQDN 'cam01.example.com' -Description 'Parking lot camera'

.EXAMPLE
# Toggle DNS validation behavior
Set-HuduIPAddress -Id 1234 -SkipDNSValidation:$false

.NOTES
If no updatable parameters are provided, the cmdlet returns the existing object and exits.
'SkipDNSValidation' is serialized as a lowercased string value per API expectations.

#>


    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id,
        [string]$Address,
        [string]$Status,
        [string]$FQDN,
        [string]$Description,
        [string]$Notes,
        [int]$AssetID,
        [int]$NetworkId,
        [int]$CompanyID,
        [bool]$SkipDNSValidation=$true
    )
        try {
            $existing = Get-HuduIPAddresses -Id $Id
        } catch {
            Write-Verbose "Unable to fetch existing IP address $Id- $_"
            return
        }

        $attrs = @{}

        if ($IncludeExisting.IsPresent -and $existing) {
            foreach ($prop in @('address','status','fqdn','description','notes','asset_id','network_id','company_id','skip_dns_validation')) {
                if ($existing.PSObject.Properties.Match($prop)) {
                    $value = $existing.$prop
                    if ($null -ne $value) { $attrs[$prop] = $value }
                }
            }
        }

        if ($PSBoundParameters.ContainsKey('Address'))        { $attrs.address             = $Address }
        if ($PSBoundParameters.ContainsKey('FQDN'))           { $attrs.fqdn                = $FQDN }
        if ($PSBoundParameters.ContainsKey('Description'))    { $attrs.description         = $Description }
        if ($PSBoundParameters.ContainsKey('Notes'))          { $attrs.notes               = $Notes }
        if ($PSBoundParameters.ContainsKey('AssetId'))        { $attrs.asset_id            = $AssetId }
        if ($PSBoundParameters.ContainsKey('NetworkId'))      { $attrs.network_id          = $NetworkId }
        if ($PSBoundParameters.ContainsKey('CompanyId'))      { $attrs.company_id          = $CompanyId }
        if ($PSBoundParameters.ContainsKey('Status'))         { $attrs.status              = "$Status".ToLower() }
        if ($PSBoundParameters.ContainsKey('SkipDNSValidation')) {
            $attrs.skip_dns_validation = "$SkipDNSValidation".ToLower()
        }

        if ($attrs.Count -eq 0) {
            Write-Verbose "No properties provided to update for IP $Id. Exiting."
            return $existing
        }

        $payload = @{ ip_address = $attrs } | ConvertTo-Json -Depth 10

        try {
            $response = Invoke-HuduRequest -Method PUT -Resource "/api/v1/ip_addresses/$Id" -Body $payload
            return $response
        } catch {
            Write-Warning "Failed to update IP address $Id- $_"
            return $null
        }

}