function New-HuduVLANZone {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
    )

    $payload = @{
        name             = $Name
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/vlan_zones" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to create vlan zone '$Name'"
        return $null
    }
}
