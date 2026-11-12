function Set-HuduAsset {
    <#
    .SYNOPSIS
    Update an Asset

    .DESCRIPTION
    Uses Hudu API to update an Asset

    .PARAMETER Name
    Name of the Asset

    .PARAMETER CompanyId
    Company id of the Asset

    .PARAMETER AssetLayoutId
    Asset layout id

    .PARAMETER Fields
    List of fields

    .PARAMETER AssetId
    Id of the requested Asset

    .PARAMETER PrimarySerial
    Primary serial number

    .PARAMETER PrimaryMail
    Primary mail

    .PARAMETER PrimaryModel
    Primary model

    .PARAMETER PrimaryManufacturer
    Primary manufacturer

    .PARAMETER Slug
    Url identifier

    .PARAMETER ExistingAsset
    The asset as already returned by Get-HuduAssets. The update is built from it instead of fetching the asset again

    .EXAMPLE
    Set-HuduAsset -AssetId 1 -CompanyId 1 -Fields @(@{'field_name'='Field Value'})

    .EXAMPLE
    Get-HuduAssets -CompanyId 1 -AssetLayoutId 2 | ForEach-Object { Set-HuduAsset -Id $_.id -ExistingAsset $_ -Fields @(@{'field_name'='Field Value'}) }

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

        [Array]$Fields,

        [Alias('asset_id','assetid')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$Id,
        
        [Alias('primary_serial')]
        [string]$PrimarySerial,

        [Alias('primary_mail')]
        [string]$PrimaryMail,

        [Alias('primary_model')]
        [string]$PrimaryModel,

        [Alias('primary_manufacturer')]
        [string]$PrimaryManufacturer,

        [string]$Slug,

        [object]$ExistingAsset
    )

    $Object = $(if ($ExistingAsset) { $ExistingAsset } else { Get-HuduAssets -id $Id }) | Select-Object name,asset_layout_id,company_id,slug,primary_serial,primary_model,primary_mail,id,primary_manufacturer,@{n='custom_fields';e={$_.fields | ForEach-Object {[pscustomobject]@{$_.label.replace(' ','_').tolower()= $_.value}}}}
    if ($Object) {
        $Asset = [ordered]@{asset = $Object }
        $CompanyId = $Object.company_id
    
        if ($Name) {
            $Asset.asset.name = $Name
        }
    
        if ($AssetLayoutId) {
            $Asset.asset.asset_layout_id = $AssetLayoutId
        }
        
        if ($PrimarySerial) {
            $Asset.asset.primary_serial = $PrimarySerial
        }
    
        if ($PrimaryMail) {
            $Asset.asset.primary_mail = $PrimaryMail
        }
    
        if ($PrimaryModel) {
            $Asset.asset.primary_model = $PrimaryModel
        }
    
        if ($PrimaryManufacturer) {
            $Asset.asset.primary_manufacturer = $PrimaryManufacturer
        }
    
        if ($Fields) {
            $Asset.asset.custom_fields = $Fields
        }
    
        if ($Slug) {
            $Asset.asset.slug = $Slug
        }
    
        $JSON = $Asset | ConvertTo-Json -Depth 10
    
        if ($PSCmdlet.ShouldProcess("ID: $($Asset.id) Name: $($Asset.Name)", "Set Hudu Asset")) {
            Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CompanyId/assets/$Id" -Body $JSON
        }
    } else {
    throw "A valid asset could not be found to update, please double check the ID and try again"
    }
}
