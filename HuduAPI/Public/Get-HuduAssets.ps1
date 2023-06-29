function Get-HuduAssets {
    <#
    .SYNOPSIS
    Get a list of Assets

    .DESCRIPTION
    Call Hudu API to retrieve Assets

    .PARAMETER Id
    Id of requested asset

    .PARAMETER AssetLayoutId
    Id of the requested asset layout

    .PARAMETER AssetLayout
    Name of the requested asset layout

    .PARAMETER CompanyId
    Id of the requested company

    .PARAMETER Name
    Filter by name

    .PARAMETER Archived
    Show archived results

    .PARAMETER PrimarySerial
    Filter by primary serial

    .PARAMETER Slug
    Filter by slug

    .PARAMETER Search
    Filter by search terms

    .PARAMETER StartDate
    Filter by updated_at property

    .PARAMETER EndDate
    Filter by updated_at property

    .PARAMETER ExactDate
    Filter by updated_at property

    .EXAMPLE
    Get-HuduAssets -AssetLayout 'Contacts'

    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    Param (
        [Parameter(ParameterSetName = 'Single')]
        [Int]$Id = '',

        [Parameter(ParameterSetName = 'List')]
        [Alias('asset_layout_id')]
        [Int]$AssetLayoutId = '',

        [Parameter(ParameterSetName = 'List')]
        [string]$AssetLayout,

        [Parameter(ParameterSetName = 'List')]
        [Alias('company_id')]
        [Int]$CompanyId = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$Name = '',

        [Parameter(ParameterSetName = 'List')]
        [switch]$Archived,

        [Parameter(ParameterSetName = 'List')]
        [Alias('primary_serial')]
        [String]$PrimarySerial = '',

        [Parameter(ParameterSetName = 'List')]
        [String]$Slug,

        [Parameter(ParameterSetName = 'List')]
        [String]$Search,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$StartDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$EndDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$ExactDate
    )

    if ($AssetLayout) {
        if (!$script:AssetLayouts) { Get-HuduAssetLayouts | Out-Null }
        $AssetLayoutId = $script:AssetLayouts | Where-Object { $_.name -eq $AssetLayout } | Select-Object -ExpandProperty id
    }

    if ($id -and $CompanyId) {
        $HuduRequest = @{
            Resource = "/api/v1/companies/$CompanyId/assets/$Id"
            Method   = 'GET'
        }
        Invoke-HuduRequest @HuduRequest
    } else {
        $Params = @{}
        if ($CompanyId) { $Params.company_id = $CompanyId }
        if ($AssetLayoutId) { $Params.asset_layout_id = $AssetLayoutId }
        if ($Name) { $Params.name = $Name }
        if ($Archived.IsPresent) { $params.archived = $Archived.IsPresent }
        if ($PrimarySerial) { $Params.primary_serial = $PrimarySerial }
        if ($Id) { $Params.id = $Id }
        if ($Slug) { $Params.slug = $Slug }
        if ($Search) { $Params.search = $Search }

        if ($StartDate) {
            $ISO8601StartDate = $StartDate.ToString('o');
        } else {
            $ISO8601StartDate = ''
        }

        if ($EndDate) {
            $ISO8601EndDate = $EndDate.ToString('o');
        } else {
            $ISO8601EndDate = ''
        }

        if (![String]::IsNullOrEmpty($StartDate) -or ![String]::IsNullOrEmpty($EndDate)) {
            $Params.updated_at = '{0},{1}' -f $ISO8601StartDate, $ISO8601EndDate
        } elseif ($ExactDate) {
            $Params.updated_at = $ExactDate.ToString('o')
        }

        $HuduRequest = @{
            Resource = '/api/v1/assets'
            Method   = 'GET'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property assets
    }
}
