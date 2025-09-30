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
    Valid field types are: Text, RichText, Heading, CheckBox, Website (aka Link), Password (aka ConfidentialText), Number, Date, DropDown (deprecated), ListSelect (replacement for Dropdown), Embed, Email (aka CopyableText), Phone, AssetLink
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

    foreach ($field in $fields) {
        if ($field.show_in_list) { $field.show_in_list = [System.Convert]::ToBoolean($field.show_in_list) } else { $field.remove('show_in_list') }
        if ($field.required) { $field.required = [System.Convert]::ToBoolean($field.required) } else { $field.remove('required') }
        if ($field.expiration) { $field.expiration = [System.Convert]::ToBoolean($field.expiration) } else { $field.remove('expiration') }
        # A bug in versions of Hudu 2.27 and earlier can cause asset layouts to become corrupted if the field type value is not properly cased.
        switch ($field.'field_type') {
            'text'              { $field.'field_type' = 'Text' }
            'richtext'          { $field.'field_type' = 'RichText' }
            'heading'           { $field.'field_type' = 'Heading' }
            'checkbox'          { $field.'field_type' = 'CheckBox' }
            'number'            { $field.'field_type' = 'Number' }
            'date'              { $field.'field_type' = 'Date' }
            'dropdown'          { Write-Warning "Dropdown Field Types have been deprecated but still available via the API. Please use ListSelect types moving forward if possible. This is not a failure."; $field.'field_type' = 'Dropdown' }
            'embed'             { $field.'field_type' = 'Embed' }
            'phone'             { $field.'field_type' = 'Phone' }
            'email'             { $field.'field_type' = 'Email' }
            'copyabletext'      { $field.'field_type' = 'Email' }
            'assettag'          { $field.'field_type' = 'AssetTag' }
            'assetlink'         { $field.'field_type' = 'AssetTag' }
            'website'           { $field.'field_type' = 'Website' }
            'link'              { $field.'field_type' = 'Website' }
            'password'          { $field.'field_type' = 'Password' }
            'confidentialtext'  { $field.'field_type' = 'Password' }
            'listselect' { $field.'field_type' = 'ListSelect' }
            Default { throw "Invalid field type: $($field.'field_type') found in field $($field.name)" }
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
