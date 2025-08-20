function Set-HuduVLANArchive {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [string]$Name,
        [Parameter(Mandatory)]
        [bool]$Archived
    )

    $payload = @{
        name             = $Name
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method PUT -Resource "/api/v1/vlans/$Id" -Body $payload
        return $res.procedure
    } catch {
        Write-Warning "Failed to archive vlan ID $Id"
        return $null
    }
}
