function Set-HuduVLAN {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [string]$Name
    )

    $payload = @{
        name             = $Name
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method PUT -Resource "/api/v1/vlans/$Id" -Body $payload
        return $res.procedure
    } catch {
        Write-Warning "Failed to vlan ID $Id"
        return $null
    }
}
