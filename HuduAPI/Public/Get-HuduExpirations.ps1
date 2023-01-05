function Get-HuduExpirations {
    [CmdletBinding()]
    Param (
        [Alias('company_id')]
        [Int]$CompanyId = '',
        [Alias('expiration_type')]
        [String]$ExpirationType = '',
        [Alias('resource_id')]
        [Int]$ResourceId = '',
        [Alias('resource_type')]
        [String]$ResourceType = ''
    )

    $ResourceFilter = ''

    if ($CompanyId) {
        $ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
    }
    if ($ExpirationType) {
        $ResourceFilter = "$($ResourceFilter)&expiration_type=$($ExpirationType)"
    }
    if ($ResourceType) {
        $ResourceFilter = "$($ResourceFilter)&resource_type=$($ResourceType)"
    }
    if ($ResourceId) {
        $ResourceFilter = "$($ResourceFilter)&resource_id=$($ResourceId)"
    }

    $i = 1;

    $AllExpirations = do {
        $Expirations = Invoke-HuduRequest -Method GET -Resource "/api/v1/expirations?page=$i&page_size=1000$($ResourceFilter)"
        $i++
        $Expirations
    } while ($Expirations.count % 1000 -eq 0 -and $Expirations.count -ne 0)

    return $AllExpirations
}
