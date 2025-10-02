function Set-HuduIPAddress {
<#
.SYNOPSIS
Update a Hudu ip address.

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