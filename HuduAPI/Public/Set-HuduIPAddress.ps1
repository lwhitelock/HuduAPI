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
    $object = Get-HuduAddresses -id $Id
    $huduaddress = [ordered]@{ip_address = $object }

    if ($Address) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name address -Force -Value $Address
    }
    if ($Status) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name status -Force -Value $Status
    }  
    if ($FQDN) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name fqdn -Force -Value $FQDN
    }       
    if ($Description) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name description -Force -Value $Description
    }       
    if ($Notes) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name notes -Force -Value $Notes
    }     
    if ($AssetId) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name asset_id -Force -Value $AssetId
    }       
    if ($NetworkId) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name network_id -Force -Value $NetworkId
    }                    
    if ($CompanyId) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name company_id -Force -Value $CompanyId
    }
    if ($SkipDNSValidation) {
        $huduaddress.network | Add-Member -MemberType NoteProperty -Name skip_dns_validation -Force -Value "$($SkipDNSValidation)".ToLower()
    }

    $payload = $huduaddress | ConvertTo-Json -depth 10
    try {
        $response = Invoke-HuduRequest -Method PUT -Resource "/api/v1/ip_addresses/$Id" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to set address '$Id'"
        return $null
    }
}