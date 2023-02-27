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
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [Alias('company_id')]
        [Parameter(Mandatory = $true)]
        [Int]$CompanyId,

        [Alias('asset_layout_id')]
        [Parameter(Mandatory = $true)]
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

    $Asset = [ordered]@{asset = [ordered]@{} }

    $Asset.asset.add('name', $Name)
    $Asset.asset.add('asset_layout_id', $AssetLayoutId)

    if ($PrimarySerial) {
        $Asset.asset.add('primary_serial', $PrimarySerial)
    }

    if ($PrimaryMail) {
        $Asset.asset.add('primary_mail', $PrimaryMail)
    }

    if ($PrimaryModel) {
        $Asset.asset.add('primary_model', $PrimaryModel)
    }

    if ($PrimaryManufacturer) {
        $Asset.asset.add('primary_manufacturer', $PrimaryManufacturer)
    }

    if ($Fields) {
        $Asset.asset.add('custom_fields', $Fields)
    }

    if ($Slug) {
        $Asset.asset.add('slug', $Slug)
    }

    $JSON = $Asset | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($ArticleId)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CompanyId/assets/$AssetId" -Body $JSON
    }
}