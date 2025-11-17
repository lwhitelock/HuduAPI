---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduAsset

## SYNOPSIS
Update an Asset

## SYNTAX

```
Set-HuduAsset [[-Name] <String>] [[-CompanyId] <Int32>] [[-AssetLayoutId] <Int32>] [[-Fields] <Array>]
 [-Id] <Int32> [[-PrimarySerial] <String>] [[-PrimaryMail] <String>] [[-PrimaryModel] <String>]
 [[-PrimaryManufacturer] <String>] [[-Slug] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to update an Asset

## EXAMPLES

### EXAMPLE 1
```
Set-HuduAsset -AssetId 1 -CompanyId 1 -Fields @(@{'field_name'='Field Value'})
```

## PARAMETERS

### -Name
Name of the Asset

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Company id of the Asset

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetLayoutId
Asset layout id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: asset_layout_id

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fields
List of fields

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
{{ Fill Id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: asset_id, assetid

Required: True
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimarySerial
Primary serial number

```yaml
Type: String
Parameter Sets: (All)
Aliases: primary_serial

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimaryMail
Primary mail

```yaml
Type: String
Parameter Sets: (All)
Aliases: primary_mail

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimaryModel
Primary model

```yaml
Type: String
Parameter Sets: (All)
Aliases: primary_model

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimaryManufacturer
Primary manufacturer

```yaml
Type: String
Parameter Sets: (All)
Aliases: primary_manufacturer

Required: False
Position: 9
Default value: None
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
General notes

## RELATED LINKS
