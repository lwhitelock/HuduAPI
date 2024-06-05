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

    .EXAMPLE
    Get-HuduAssets -AssetLayout 'Contacts'

    #>
    [CmdletBinding()]
    Param (
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$Id = '',
        [Alias('asset_layout_id')]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$AssetLayoutId = '',
        [string]$AssetLayout,
        [Alias('company_id')]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$CompanyId = '',
        [String]$Name = '',
        [switch]$Archived,
        [Alias('primary_serial')]
        [String]$PrimarySerial = '',
        [String]$Slug
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

        $HuduRequest = @{
            Resource = '/api/v1/assets'
            Method   = 'GET'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property assets
    }
}
