function Set-HuduIntegrationMatcher {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Id,

        [Parameter(ParameterSetName = 'AcceptSuggestedMatch')]
        [switch]$AcceptSuggestedMatch,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetCompanyId')]
        [Alias('company_id')]
        [String]$CompanyId,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('potential_company_id')]
        [String]$PotentialCompanyId,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('sync_id')]
        [String]$SyncId,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [String]$Identifier
    )

    Process {
        $Matcher = [ordered]@{matcher = [ordered]@{} }
	
        if ($AcceptSuggestedMatch) {
            $Matcher.matcher.add('company_id', $PotentialCompanyId) | Out-Null
        }
        else {
            $Matcher.matcher.add('company_id', $CompanyId) | Out-Null
        }

        if ($PotentialCompanyId) {
            $Matcher.matcher.add('potential_company_id', $PotentialCompanyId) | Out-Null
        }
        if ($SyncId) {
            $Matcher.matcher.add('sync_id', $SyncId) | Out-Null
        }
        if ($Identifier) {
            $Matcher.matcher.add('identifier', $identifier) | Out-Null
        }
	
        $JSON = $Matcher | ConvertTo-Json -Depth 10
	
        $Response = Invoke-HuduRequest -Method put -Resource "/api/v1/matchers/$Id" -Body $JSON
        $Response
    }
}
