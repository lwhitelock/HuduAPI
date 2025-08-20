function Remove-HuduVLAN {
<#
.SYNOPSIS
Delete a VLAN from Hudu.

.DESCRIPTION
Removes the VLAN with the specified Id. Supports `-WhatIf`/`-Confirm`.

.PARAMETER Id
The Id of the VLAN to delete.

.EXAMPLE
Remove-HuduVLAN -Id 45 -Confirm:$false
#>    
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)] [int]$Id
    )
    $response = $null
    try {
        $response = Invoke-HuduRequest -Method DELETE -Resource "/api/v1/vlans/$Id"
        Write-Host "Successfully deleted vlan ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete vlan ID $Id"
    }
    return $response
}
