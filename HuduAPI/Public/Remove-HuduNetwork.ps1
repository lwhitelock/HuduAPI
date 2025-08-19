function Remove-HuduNetwork {
<#
.SYNOPSIS
Delete a Hudu network.

.DESCRIPTION
Deletes a Hudu IPAM Network from a Company. Writes a success message if the
deletion is acknowledged by the API, otherwise writes a warning.

.PARAMETER Id
The unique network ID to delete. (Required)

.EXAMPLE
Remove-HuduNetwork -Id 123
#>    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id
    )

    try {
        Invoke-HuduRequest -Method DELETE -Resource "/api/v1/networks/$Id"
        Write-Host "Successfully deleted network ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete network ID $Id"
    }
}