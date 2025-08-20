function Remove-HuduVLANZone {
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
