function Get-HuduAssetLayouts {
    <#
    .SYNOPSIS
    Get a list of Asset Layouts

    .DESCRIPTION
    Call Hudu API to retrieve asset layouts for server

    .PARAMETER Name
    Filter by name of Asset Layout

    .PARAMETER LayoutId
    Id of Asset Layout

    .PARAMETER Slug
    Filter by url slug

    .PARAMETER UpdatedAfter
    Get asset layouts Updated After X datetime
    
    .PARAMETER UpdatedBefore
    Get asset layouts Updated Before Y datetime

    .EXAMPLE
    Get-HuduAssetLayouts -Name 'Contacts'
    Get-HuduAssetLayouts -UpdatedBefore $(get-date).AddDays(-3)

    #>
    [CmdletBinding()]
    Param (
        [String]$Name,
        [Alias('id', 'layout_id')]
        [int]$LayoutId,
        [String]$Slug,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore        
    )

    $HuduRequest = @{
        Resource = '/api/v1/asset_layouts'
        Method   = 'GET'
    }

    if ($LayoutId) {
        $HuduRequest.Resource = '{0}/{1}' -f $HuduRequest.Resource, $LayoutId
        $AssetLayout = Invoke-HuduRequest @HuduRequest
        return $AssetLayout.asset_layout
    } else {
        $Params = @{}
        if ($Name) { $Params.name = $Name }
        if ($Slug) { $Params.slug = $Slug }
        $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
        if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
            $Params.updated_at = $updatedRange
        }

        $HuduRequest.Params = $Params

        $AssetLayouts = Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'asset_layouts' -PageSize 25

        if (!$Name -and !$Slug) {
            $script:AssetLayouts = $AssetLayouts | Sort-Object -Property name
        }
        $AssetLayouts
    }
}
