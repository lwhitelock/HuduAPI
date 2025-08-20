function New-HuduVLANZone {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [int]$CompanyId,
        [string]$Description,
        [Parameter(Mandatory)][string]$VLANIdRanges,
        [string]$Archived='false'
    )

    $vlan_zone = @{name=$Name; company_id = $CompanyId}
    if ($Description) {
        $vlan_zone['description']=$Description
    }
    if ($VLANIdRanges) {
        $vlan_zone['vlan_id_ranges']=$VLANIdRanges
    }
    if ($Archived) {
        $vlan_zone['archived']=$Archived
    }
   
    $payload = @{
        vlan_zone = $vlan_zone
    } | ConvertTo-Json -Depth 10
    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/vlan_zones" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to create vlan zone '$Name'"
        return $null
    }
}
