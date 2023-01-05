function Get-HuduIntegrationMatchers {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [int]$IntegrationId,
        [switch]$Matched,
        [int]$SyncId = '',
        [string]$Identifier = '',
        [int]$CompanyId
    )
		
    $ResourceFilter = '&integration_id={0}' -f $IntegrationId

    if ($Matched) { $ResourceFilter = "$($ResourceFilter)&matched=true" }
    else { $ResourceFilter = "$($ResourceFilter)&matched=false" }

    if ($CompanyId) {
        $ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
    }
    if ($Identifier) {
        $ResourceFilter = "$($ResourceFilter)&identifier=$($Identifier)"
    }
    if ($SyncId) {
        $ResourceFilter = "$($ResourceFilter)&sync_id=$($SyncId)"
    }
		
    $i = 1;
    $AllMatchers = do {
        $Matchers = Invoke-HuduRequest -Method get -Resource "/api/v1/matchers?page=$i&page_size=1000$($ResourceFilter)"
        $i++
        $Matchers
    } while ($Matchers.matchers.count % 1000 -eq 0 -and $Matchers.matchers.count -ne 0)
				
    return $AllMatchers.matchers
}
