function Set-HuduAssetLayoutField {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$LayoutId,

        [Parameter(Mandatory)]
        [string]$FieldLabel,

        [Parameter(Mandatory)]
        [string]$PropertyName,

        [Parameter(Mandatory)]
        $PropertyValue
    )

    # 1. Get full layout
    $layout = Get-HuduAssetLayouts -layoutid $LayoutId
    if (-not $layout) {
        throw "Layout ID $LayoutId not found."
    }

    # 2. Convert PSCustomObject fields → Hashtables Hudu accepts
    $fields = foreach ($f in $layout.fields) {
        $ht = @{}
        foreach ($p in $f.PSObject.Properties) {
            # Preserve only non-empty values to match Hudu’s preferred formatting
            if ($null -ne $p.Value -and $p.Value -ne "") {
                $ht[$p.Name] = $p.Value
            }
        }
        $ht
    }

    # 3. Locate the field by label
    $target = $fields | Where-Object { $_.label -eq $FieldLabel }

    if (-not $target) {
        throw "Field '$FieldLabel' not found on layout $LayoutId."
    }

    # 4. Apply mutation
    $target[$PropertyName] = $PropertyValue

    # 5. Repost the entire layout using original layout properties
    $null = Set-HuduAssetLayout `
        -id $layout.id `
        -name $layout.name `
        -icon $layout.icon `
        -color $layout.color `
        -icon_color $layout.icon_color `
        -include_passwords $layout.include_passwords `
        -include_photos $layout.include_photos `
        -include_comments $layout.include_comments `
        -include_files $layout.include_files `
        -fields $fields

    # 6. Return updated object
    return Get-HuduAssetLayouts -layoutid $LayoutId
}
