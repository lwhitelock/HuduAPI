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
New-HuduAssetLayout -Name 'Routers' -Icon 'fas fa-network-wired' -Color 'azul' -IconColor '#ffffff' -Fields @(
    @{label = 'Hostname'; 'field_type' = 'Text'}
)
```

### EXAMPLE 3
```
New-HuduAssetLayout -Name 'Routers' -Icon 'fas fa-network-wired' -Color 'azul' -IconColor '#ffffff' -SidebarFolderID 3 -Fields @(
    @{label = 'Hostname'; 'field_type' = 'Text'}
)
```

### EXAMPLE 4
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
Background color as a hex value, such as #ff0000, or a human-readable color
name in a supported language.
Alpha values are trimmed off.

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
Icon color as a hex value, such as #ff0000, or a human-readable color
name in a supported language.
Alpha values are trimmed off.

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
Default value: False
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
Default value: False
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
Default value: False
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

For Number fields, `number_type` accepts `number`, `currency`, or `percentage` (`percent` is an alias). Values are trimmed and normalized to lowercase; unknown types are rejected before sending a request.

- Omit both `number_type` and `currency_code` to retain Hudu's ordinary number default.
- Supply only `currency_code` to infer `number_type = 'currency'`.
- An explicit `number` or `percentage` takes precedence and removes any stale `currency_code`.
- Currency fields use the supplied, normalized ISO 4217 code. Missing or invalid codes fall back to the executing PowerShell session's culture, then `USD` if no regional currency is available.

Culture is read from `Get-Culture`, not from Hudu or the company being documented. For predictable automation across regions, supply an explicit currency code. Current ISO 4217 codes and retained legacy codes are accepted; the allowlist is local and requires no runtime network request.

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
