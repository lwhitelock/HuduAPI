function New-HuduVLAN {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
    )

    $payload = @{
        name             = $Name
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/vlans" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to create vlan '$Name'"
        return $null
    }
}
