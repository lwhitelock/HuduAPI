function New-HuduAssetLayout {
    <#
    .SYNOPSIS
    Create an Asset Layout

    .DESCRIPTION
    Uses Hudu API to create new custom asset layout

    .PARAMETER Name
    Name of the layout

    .PARAMETER Icon
    FontAwesome Icon class name, example: "fas fa-home"

    .PARAMETER Color
    Background color hex code

    .PARAMETER IconColor
    Icon color hex code

    .PARAMETER IncludePasswords
    Boolean for including passwords

    .PARAMETER IncludePhotos
    Boolean for including photos

    .PARAMETER IncludeComments
    Boolean for including comments

    .PARAMETER IncludeFiles
    Boolean for including files

    .PARAMETER PasswordTypes
    List of password types, separated with new line characters

    .PARAMETER Slug
    Url identifier

    .PARAMETER Fields
    Array of nested fields

    .EXAMPLE
    New-HuduAssetLayout -Name 'Test asset layout' -Icon 'fas fa-home' -IncludePassword $true

    #>
    [CmdletBinding(SupportsShouldProcess)]
    # This will silence the warning for variables with Password in their name.
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [Parameter(Mandatory = $true)]
        [String]$Icon,

        [Parameter(Mandatory = $true)]
        [String]$Color,

        [Alias('icon_color')]
        [Parameter(Mandatory = $true)]
        [String]$IconColor,

        [Alias('include_passwords')]
        [bool]$IncludePasswords = '',

        [Alias('include_photos')]
        [bool]$IncludePhotos = '',

        [Alias('include_comments')]
        [bool]$IncludeComments = '',

        [Alias('include_files')]
        [bool]$IncludeFiles = '',

        [Alias('password_types')]
        [String]$PasswordTypes = '',

        [Parameter(Mandatory = $true)]
        [system.collections.generic.list[hashtable]]$Fields
    )

    foreach ($field in $fields) {
        if ($field.show_in_list) { $field.show_in_list = [System.Convert]::ToBoolean($field.show_in_list) } else { $field.remove('show_in_list') }
        if ($field.required) { $field.required = [System.Convert]::ToBoolean($field.required) } else { $field.remove('required') }
        if ($field.expiration) { $field.expiration = [System.Convert]::ToBoolean($field.expiration) } else { $field.remove('expiration') }
    }

    $AssetLayout = [ordered]@{asset_layout = [ordered]@{} }

    $AssetLayout.asset_layout.add('name', $Name)
    $AssetLayout.asset_layout.add('icon', $Icon)
    $AssetLayout.asset_layout.add('color', $Color)
    $AssetLayout.asset_layout.add('icon_color', $IconColor)
    $AssetLayout.asset_layout.add('fields', $Fields)
    #$AssetLayout.asset_layout.add('active', $Active)

    if ($IncludePasswords) {
        $AssetLayout.asset_layout.add('include_passwords', [System.Convert]::ToBoolean($IncludePasswords))
    }

    if ($IncludePhotos) {
        $AssetLayout.asset_layout.add('include_photos', [System.Convert]::ToBoolean($IncludePhotos))
    }

    if ($IncludeComments) {
        $AssetLayout.asset_layout.add('include_comments', [System.Convert]::ToBoolean($IncludeComments))
    }

    if ($IncludeFiles) {
        $AssetLayout.asset_layout.add('include_files', [System.Convert]::ToBoolean($IncludeFiles))
    }

    if ($PasswordTypes) {
        $AssetLayout.asset_layout.add('password_types', $PasswordTypes)
    }

    if ($Slug) {
        $AssetLayout.asset_layout.add('slug', $Slug)
    }

    $JSON = $AssetLayout | ConvertTo-Json -Depth 10

    Write-Verbose $JSON

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method post -Resource '/api/v1/asset_layouts' -Body $JSON
    }
}
