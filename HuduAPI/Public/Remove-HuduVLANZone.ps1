function Remove-HuduVLANZone {
<#
.SYNOPSIS
Delete a VLAN Zone from Hudu.

.DESCRIPTION
Removes the VLAN Zone with the specified Id. Supports `-WhatIf`/`-Confirm`.

.PARAMETER Id
The Id of the VLAN Zone to delete.

.EXAMPLE
Remove-HuduVLANZone -Id 12 -Confirm:$false
#>    
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)] [int]$Id
    )
    $response = $null
    try {
        $response = Invoke-HuduRequest -Method DELETE -Resource "/api/v1/vlan_zones/$Id"
        Write-Host "Successfully deleted vlan zone ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete vlan zone ID $Id"
    }
    return $response
}
