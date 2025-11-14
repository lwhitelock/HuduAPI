function Remove-HuduIPAddress {
<#
.SYNOPSIS
Delete a Hudu network.

.DESCRIPTION
Deletes one Hudu IPAM IP address objects.

.PARAMETER Id
IP address record ID to retrieve (exact match).

#>    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id
    )

    try {
        Invoke-HuduRequest -Method DELETE -Resource "/api/v1/ip_addresses/$Id"
        Write-Host "Successfully deleted address ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete address ID $Id"
    }
}