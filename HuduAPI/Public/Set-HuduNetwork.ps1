function Set-HuduNetwork {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id,
        [string]$Name,
        [string]$Address,
        [int]$CompanyId,
        [int]$LocationId,
        [string]$Description,
        [int]$NetworkType,
        [int]$VlanId
    )
    $object = Get-HuduNetworks -id $Id
    $hudunetwork = [ordered]@{network = $object }

    if ($Name) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name name -Force -Value $Name
    }
    if ($Address) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name address -Force -Value $Address
    }
    if ($CompanyId) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name company_id -Force -Value $CompanyId
    }
    if ($LocationId) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name location_id -Force -Value $LocationId
    }
    if ($Description) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name description -Force -Value $Description
    }
    if ($NetworkType) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name network_type -Force -Value $NetworkType
    }
    if ($VlanId) {
        $hudunetwork.network | Add-Member -MemberType NoteProperty -Name vlan_id -Force -Value $VlanId
    }
 


    $payload = $hudunetwork | ConvertTo-Json -depth 10
    try {
        $response = Invoke-HuduRequest -Method PUT -Resource "/api/v1/networks/$Id" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to set network '$Id'"
        return $null
    }
}