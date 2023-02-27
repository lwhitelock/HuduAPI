function Set-HuduIntegrationMatcher {
    <#
    .SYNOPSIS
    Update a Matcher

    .DESCRIPTION
    Uses Hudu API to set integration matchers

    .PARAMETER Id
    Id of the requested matcher

    .PARAMETER AcceptSuggestedMatch
    Set the Sync Id/Identifier to the suggested one

    .PARAMETER CompanyId
    Requested company id to match

    .PARAMETER PotentialCompanyId
    Potential company id to match

    .PARAMETER SyncId
    Sync id to match

    .PARAMETER Identifier
    Identifier to match

    .EXAMPLE
    Set-HuduIntegrationMatcher -Id 1 -AcceptSuggestedMatch

    #>
    [CmdletBinding(SupportsShouldProcess)]
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

    process {
        $Matcher = [ordered]@{matcher = [ordered]@{} }

        if ($AcceptSuggestedMatch) {
            $Matcher.matcher.add('company_id', $PotentialCompanyId) | Out-Null
        } else {
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

        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method put -Resource "/api/v1/matchers/$Id" -Body $JSON
        }
    }
}
