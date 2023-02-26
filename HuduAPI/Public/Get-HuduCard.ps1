function Get-HuduCard {
    <#
    .SYNOPSIS
    Get Integration Cards

    .DESCRIPTION
    Lookup cards with outside integration details

    .PARAMETER IntegrationSlug
    Identifier of outside integration

    .PARAMETER IntegrationId
    ID in the integration. Must be present, unless integration_identifier is set

    .PARAMETER IntegrationIdentifier
    Identifier in the integration (if integration_id is not set)

    .EXAMPLE
    Get-HuduCard -IntegrationSlug cw_manage -IntegrationId 1

    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [Alias('integration_slug')]
        [String]$IntegrationSlug,

        [Alias('integration_id')]
        [String]$IntegrationId,

        [Alias('integration_identifier')]
        [String]$IntegrationIdentifier
    )

    $Params = @{
        integration_slug = $IntegrationSlug
    }

    if ($IntegrationId) { $Params.integration_id = $IntegrationId }
    if ($IntegrationIdentifier) { $Params.integration_identifier = $IntegrationIdentifier }

    if (!$IntegrationId -and !$IntegrationIdentifier) {
        throw 'IntegrationId or IntegrationIdentifier required'
    }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/cards/lookup'
        Params   = $Params
    }

    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property integrator_cards
}
