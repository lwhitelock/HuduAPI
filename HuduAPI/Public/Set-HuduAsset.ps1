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

    .EXAMPLE
    Set-HuduAsset -AssetId 1 -CompanyId 1 -Fields @(@{'field_name'='Field Value'})

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

        [Alias('asset_id')]
        [Parameter(Mandatory = $true)]
        [Int]$AssetId,

        [Alias('primary_serial')]
        [string]$PrimarySerial,

        [Alias('primary_mail')]
        [string]$PrimaryMail,

        [Alias('primary_model')]
        [string]$PrimaryModel,

        [Alias('primary_manufacturer')]
        [string]$PrimaryManufacturer,

        [string]$Slug
    )
    $Object = Get-HuduAssets -id $AssetId
    $Asset = [ordered]@{asset = $Object }

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

    if ($PSCmdlet.ShouldProcess($ArticleId)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CompanyId/assets/$AssetId" -Body $JSON
    }
}