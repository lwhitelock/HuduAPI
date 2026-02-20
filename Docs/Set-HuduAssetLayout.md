---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduAssetLayout

## SYNOPSIS
Update an Asset Layout

## SYNTAX

```
Set-HuduAssetLayout [-Id] <Int32> [[-Name] <String>] [[-Icon] <String>] [[-Color] <String>]
 [[-IconColor] <String>] [[-IncludePasswords] <Boolean>] [[-IncludePhotos] <Boolean>]
 [[-IncludeComments] <Boolean>] [[-IncludeFiles] <Boolean>] [[-PasswordTypes] <String>] [[-Active] <Boolean>]
 [[-Slug] <String>] [[-Fields] <Array>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to update an Asset Layout

## EXAMPLES

### EXAMPLE 1
```
Set-HuduAssetLayout -Id 12 -Name 'Test asset layout' -Icon 'fas fa-home' -IncludePassword $true
```

### EXAMPLE 2
```
Set-HuduAssetLayout -Id 12 -Fields @(
    @{label = 'Test field'; 'field_type' = 'Text'}
)
```

## PARAMETERS

### -Id
Id of the requested Asset Layout

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Asset Layout

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
Icon class name, example: "fas fa-home"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
Hex code for background color, example: #000000

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconColor
Hex code for background color, example: #000000

```yaml
Type: String
Parameter Sets: (All)
Aliases: icon_color

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludePasswords
Boolean to include passwords

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_passwords

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludePhotos
Boolean to include photos

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_photos

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeComments
Boolean to include comments

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_comments

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeFiles
Boolean to include files

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_files

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordTypes
List of password types, separated with new line characters

```yaml
Type: String
Parameter Sets: (All)
Aliases: password_types

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
{{ Fill Active Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Url identifier

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fields
Array of hashtable or custom objects representing layout fields.
Most field types only require a label and type.
Valid field types are: Text, RichText, Heading, CheckBox, Website (aka Link), Password (aka ConfidentialText), Number, Date, DropDown (deprecated), ListSelect (replacement for Dropdown), Embed, Email (aka CopyableText), Phone, AssetLink
Field types are Case Sensitive as of Hudu V2.27 due to a known issue with asset type validation.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
