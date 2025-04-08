function Move-HuduAssetsToNewLayout {
    <#
    .SYNOPSIS
    Moves an Asset between two Asset Layouts

    .DESCRIPTION
    Uses Hudu API to move an Asset from one Asset Layout to another
    
    .PARAMETER CompanyId
    Company id of the Asset

    .PARAMETER AssetLayoutId
    New Asset layout id where the asset will be moved to

    .PARAMETER AssetId
    Id of the Asset to move
    
    .EXAMPLE
    Move-HuduAssetsToNewLayout -AssetId 5 -CompanyId 1 -AssetLayoutId 5

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [String]$Name,

        [Alias('company_id')]
        [Int]$CompanyId,

        [Alias('asset_layout_id')]
        [Int]$AssetLayoutId,

        [Alias('asset_id','assetid')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$Id
    )
    
    $Object = Get-HuduAssets -id $Id | Select-Object name,asset_layout_id,company_id,slug,primary_serial,primary_model,primary_mail,id,primary_manufacturer,@{n='custom_fields';e={$_.fields | ForEach-Object {[pscustomobject]@{$_.label.replace(' ','_').tolower()= $_.value}}}}
    if ($Object) {
        $Asset = [pscustomobject]@{asset_layout_id = $AssetLayoutId}
    
    
        $JSON = $Asset | ConvertTo-Json -Depth 10
    
        if ($PSCmdlet.ShouldProcess("ID: $($Asset.id) Name: $($Asset.Name)", "Move Asset from Layout $($Object.asset_layout_id) to $($AssetLayoutId)")) {
            Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CompanyId/assets/$Id/move_layout" -Body $JSON
        }
    } else {
    throw "A valid asset could not be found to update, please double check the ID and try again"
    }
}
