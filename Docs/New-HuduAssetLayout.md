---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduAssetLayout

## SYNOPSIS
Create an Asset Layout

## SYNTAX

```
New-HuduAssetLayout [-Name] <String> [-Icon] <String> [-Color] <String> [-IconColor] <String>
 [[-IncludePasswords] <Boolean>] [[-IncludePhotos] <Boolean>] [[-IncludeComments] <Boolean>]
 [[-IncludeFiles] <Boolean>] [[-PasswordTypes] <String>]
 [-Fields] <System.Collections.Generic.List`1[System.Collections.Hashtable]>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to create new custom asset layout

## EXAMPLES

### EXAMPLE 1
```
New-HuduAssetLayout -Name 'Test asset layout' -Icon 'fas fa-home' -IncludePassword $true
```

### EXAMPLE 2
```
New-HuduAssetLayout -Name 'Test asset layout' -Icon 'fas fa-home' -IncludePassword $true -Fields @(
    @{label = 'Test field'; 'field_type' = 'Text'}
)
```

## PARAMETERS

### -Name
Name of the layout

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
FontAwesome Icon class name, example: "fas fa-home"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
Background color hex code

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconColor
Icon color hex code

```yaml
Type: String
Parameter Sets: (All)
Aliases: icon_color

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludePasswords
Boolean for including passwords

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_passwords

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludePhotos
Boolean for including photos

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_photos

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeComments
Boolean for including comments

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_comments

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeFiles
Boolean for including files

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_files

Required: False
Position: 8
Default value: None
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
Position: 9
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
Type: System.Collections.Generic.List`1[System.Collections.Hashtable]
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
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
