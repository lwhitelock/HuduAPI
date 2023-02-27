function Get-HuduIntegrationMatchers {
    <#
    .SYNOPSIS
    List matchers for an integration

    .DESCRIPTION
    Calls Hudu API to get list of integration matching

    .PARAMETER IntegrationId
    ID of the integration. Can be found in the URL when editing an integration

    .PARAMETER Matched
    Filter on whether the company already been matched

    .PARAMETER SyncId
    Filter by ID of the record in the integration. This is used if the id that the integration uses is an integer.

    .PARAMETER Identifier
    Filter by Identifier in the integration (if sync_id is not set). This is used if the id that the integration uses is a string.

    .PARAMETER CompanyId
    Filter on company id

    .EXAMPLE
    Get-HuduIntegrationMatchers -IntegrationId 1

    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [int]$IntegrationId,

        [switch]$Matched,

        [int]$SyncId = '',

        [string]$Identifier = '',

        [int]$CompanyId
    )

    $Params = @{
        integration_id = $IntegrationId
    }

    if ($Matched.IsPresent) { $Params.matched = 'true' }
    if ($CompanyId) { $Params.company_id = $CompanyId }
    if ($Identifier) { $Params.identifier = $Identifier }
    if ($SyncId) { $Params.sync_id = $SyncId }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/matchers'
        Params   = $Params
    }
    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'matchers'
}
