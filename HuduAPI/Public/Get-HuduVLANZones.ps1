function Get-HuduVLANZones {
    [CmdletBinding()]
    param(
        [int]$Id
    )

    if ($Id) {
        try {
            $res = Invoke-HuduRequest -Method GET -Resource "/api/v1/vlan_zones/$Id"
            return $res
        } catch {
            Write-Warning "Failed to retrieve vlan zone ID $Id"
            return $null
        }
    }

    $params = @{}
    if ($Name)        { $params.name         = $Name }

    Invoke-HuduRequestPaginated -HuduRequest @{
        Method   = 'GET'
        Resource = '/api/v1/vlan_zones'
        Params   = $params
    } -Property vlans
}
