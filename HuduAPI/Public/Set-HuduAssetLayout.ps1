function Set-HuduAssetLayout {
    <#
    .SYNOPSIS
    Update an Asset Layout

    .DESCRIPTION
    Uses Hudu API to update an Asset Layout

    .PARAMETER Id
    Id of the requested Asset Layout

    .PARAMETER Name
    Name of the Asset Layout

    .PARAMETER Icon
    Icon class name, example: "fas fa-home"

    .PARAMETER Color
    Hex code for background color, example: #000000

    .PARAMETER IconColor
    Hex code for background color, example: #000000

    .PARAMETER IncludePasswords
    Boolean to include passwords

    .PARAMETER IncludePhotos
    Boolean to include photos

    .PARAMETER IncludeComments
    Boolean to include comments

    .PARAMETER IncludeFiles
    Boolean to include files

    .PARAMETER PasswordTypes
    List of password types, separated with new line characters

    .PARAMETER Slug
    Url identifier

    .PARAMETER Fields
    Array of hashtable or custom objects representing layout fields. Most field types only require a label and type.
    Valid field types are: Text, RichText, Heading, CheckBox, Website (aka Link), Password (aka ConfidentialText), Number, Date, DropDown, Embed, Email (aka CopyableText), Phone, AssetLink
    Field types are Case Sensitive as of Hudu V2.27 due to a known issue with asset type validation.

    .EXAMPLE
    Set-HuduAssetLayout -Id 12 -Name 'Test asset layout' -Icon 'fas fa-home' -IncludePassword $true

    .EXAMPLE
    Set-HuduAssetLayout -Id 12 -Fields @(
        @{label = 'Test field'; 'field_type' = 'Text'}
    )
    #>
    [CmdletBinding(SupportsShouldProcess)]
    # This will silence the warning for variables with Password in their name.
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,

        [String]$Name,

        [String]$Icon,

        [String]$Color,

        [Alias('icon_color')]
        [String]$IconColor,

        [Alias('include_passwords')]
        [bool]$IncludePasswords,

        [Alias('include_photos')]
        [bool]$IncludePhotos,

        [Alias('include_comments')]
        [bool]$IncludeComments,

        [Alias('include_files')]
        [bool]$IncludeFiles,

        [Alias('password_types')]
        [String]$PasswordTypes = '',

        [bool]$Active,

        [string]$Slug,

        [array]$Fields
    )

    foreach ($Field in $Fields) {
        $Field.show_in_list = [System.Convert]::ToBoolean($Field.show_in_list)
        $Field.required = [System.Convert]::ToBoolean($Field.required)
        $Field.expiration = [System.Convert]::ToBoolean($Field.expiration)
        # A bug in versions of Hudu 2.27 and earlier can cause asset layouts to become corrupted if the field type value is not properly cased.
        switch ($field.'field_type') {
            'text'              { $field.'field_type' = 'Text' }
            'richtext'          { $field.'field_type' = 'RichText' }
            'heading'           { $field.'field_type' = 'Heading' }
            'checkbox'          { $field.'field_type' = 'CheckBox' }
            'number'            { $field.'field_type' = 'Number' }
            'date'              { $field.'field_type' = 'Date' }
            'dropdown'          { $field.'field_type' = 'Dropdown' }
            'embed'             { $field.'field_type' = 'Embed' }
            'phone'             { $field.'field_type' = 'Phone' }
            {$_ -in 'email','copyabletext'}     { $field.'field_type' = 'Email' }
            {$_ -in 'assettag','assetlink'}        { $field.'field_type' = 'AssetTag' }
            {$_ -in 'website','link'}             { $field.'field_type' = 'Website' }
            {$_ -in 'password','confidentialtext'} { $field.'field_type' = 'Password' }
            Default { Write-Error "Invalid field type: $($field.'field_type') found in field $($field.name)"; break }
        }
    }
    $Object = Get-HuduAssetLayouts -id $Id

    $AssetLayout = [ordered]@{asset_layout = $Object }
    #$AssetLayout.asset_layout = $Object

    if ($Name) {
        $AssetLayout.asset_layout.name = $Name
    }
    
    if ($Icon) {
        $AssetLayout.asset_layout.icon = $Icon
    }

    if ($Color) {
        $AssetLayout.asset_layout.color = $Color
    }

    if ($IconColor) {
        $AssetLayout.asset_layout.icon_color = $IconColor
    }

    if ($Fields) {
        $AssetLayout.asset_layout.fields = $Fields
    }

    if ($IncludePasswords) {
        $AssetLayout.asset_layout.include_passwords = [System.Convert]::ToBoolean($IncludePasswords)
    }

    if ($IncludePhotos) {
        $AssetLayout.asset_layout.include_photos = [System.Convert]::ToBoolean($IncludePhotos)
    }

    if ($IncludeComments) {
        $AssetLayout.asset_layout.include_comments = [System.Convert]::ToBoolean($IncludeComments)
    }

    if ($IncludeFiles) {
        $AssetLayout.asset_layout.include_files = [System.Convert]::ToBoolean($IncludeFiles)
    }

    if ($PasswordTypes) {
        $AssetLayout.asset_layout.password_types = $PasswordTypes
    }

    if ($SidebarFolderID) {
        $AssetLayout.asset_layout.sidebar_folder_id = $SidebarFolderID
    }

    if ($Slug) {
        $AssetLayout.asset_layout.slug = $Slug
    }

    if ($Active) {
        $AssetLayout.asset_layout.active = [System.Convert]::ToBoolean($Active)
    }

    $JSON = $AssetLayout | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/asset_layouts/$Id" -Body $JSON
    }
}
