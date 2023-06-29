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

    .PARAMETER StartDate
    Filter by updated_at property

    .PARAMETER EndDate
    Filter by updated_at property

    .PARAMETER ExactDate
    Filter by updated_at property

    .EXAMPLE
    Get-HuduAssetLayouts -Name 'Contacts'

    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    Param (
        [Parameter(ParameterSetName = 'List')]
        [String]$Name,

        [Parameter(ParameterSetName = 'Single')]
        [Alias('id', 'layout_id')]
        [int]$LayoutId,

        [Parameter(ParameterSetName = 'List')]
        [String]$Slug,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$StartDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$EndDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$ExactDate
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

        $HuduRequest.Params = $Params

        $AssetLayouts = Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'asset_layouts' -PageSize 25

        if (!$Name -and !$Slug) {
            $script:AssetLayouts = $AssetLayouts | Sort-Object -Property name
        }
        $AssetLayouts
    }
}
