function Get-HuduVLANs {
    [CmdletBinding()]
    param(
        [int]$Id
    )

    if ($Id) {
        try {
            $res = Invoke-HuduRequest -Method GET -Resource "/api/v1/vlans/$Id"
            return $res
        } catch {
            Write-Warning "Failed to retrieve vlan ID $Id"
            return $null
        }
    }

    $params = @{}
    if ($Name)        { $params.name         = $Name }

    Invoke-HuduRequestPaginated -HuduRequest @{
        Method   = 'GET'
        Resource = '/api/v1/vlans'
        Params   = $params
    } -Property vlans
}
