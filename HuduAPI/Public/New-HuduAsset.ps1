function New-HuduAsset {
    <#
    .SYNOPSIS
    Create an Asset

    .DESCRIPTION
    Uses Hudu API to create assets using custom layouts

    .PARAMETER Name
    Name of the Asset

    .PARAMETER CompanyId
    Company id for asset

    .PARAMETER AssetLayoutId
    Asset layout id

    .PARAMETER Fields
    Array of custom fields and values

    .PARAMETER PrimarySerial
    Asset primary serial number

    .PARAMETER PrimaryMail
    Asset primary mail

    .PARAMETER PrimaryModel
    Asset primary model

    .PARAMETER PrimaryManufacturer
    Asset primary manufacturer

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    New-HuduAsset -Name 'Some asset' -CompanyId 1 -Fields @(@{'field_name'='Field Value'})

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

        [Alias('primary_serial')]
        [string]$PrimarySerial,

        [Alias('primary_mail')]
        [string]$PrimaryMail,

        [Alias('primary_model')]
        [string]$PrimaryModel,

        [Alias('primary_manufacturer')]
        [string]$PrimaryManufacturer
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

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method post -Resource "/api/v1/companies/$CompanyId/assets" -Body $JSON
    }
}
