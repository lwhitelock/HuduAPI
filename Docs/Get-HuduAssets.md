---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduAssets

## SYNOPSIS
Get a list of Assets

## SYNTAX

### List (Default)
```
Get-HuduAssets [-AssetLayoutId <Int32>] [-AssetLayout <String>] [-CompanyId <Int32>] [-Name <String>]
 [-Archived] [-PrimarySerial <String>] [-Slug <String>] [-Search <String>] [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-ExactDate <DateTime>] [<CommonParameters>]
```

### Single
```
Get-HuduAssets [-Id <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Call Hudu API to retrieve Assets

## EXAMPLES

### EXAMPLE 1
```
Get-HuduAssets -AssetLayout 'Contacts'
```

## PARAMETERS

### -Id
Id of requested asset

```yaml
Type: Int32
Parameter Sets: Single
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetLayoutId
Id of the requested asset layout

```yaml
Type: Int32
Parameter Sets: List
Aliases: asset_layout_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetLayout
Name of the requested asset layout

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Id of the requested company

```yaml
Type: Int32
Parameter Sets: List
Aliases: company_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Filter by name

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archived
Show archived results

```yaml
Type: SwitchParameter
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimarySerial
Filter by primary serial

```yaml
Type: String
Parameter Sets: List
Aliases: primary_serial

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by slug

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Search
Filter by search terms

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
Filter by updated_at property

```yaml
Type: DateTime
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
Filter by updated_at property

```yaml
Type: DateTime
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExactDate
Filter by updated_at property

```yaml
Type: DateTime
Parameter Sets: List
Aliases:

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
