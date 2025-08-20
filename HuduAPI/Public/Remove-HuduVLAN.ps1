function Remove-HuduVLAN {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)] [int]$Id
    )
    $response = $null
    try {
        $response = Invoke-HuduRequest -Method DELETE -Resource "/api/v1/vlan/$Id"
        Write-Host "Successfully deleted vlan ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete vlan ID $Id"
    }
    return $response
}
