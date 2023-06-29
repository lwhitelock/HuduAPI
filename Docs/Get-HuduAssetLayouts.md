---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduAssetLayouts

## SYNOPSIS
Get a list of Asset Layouts

## SYNTAX

### List (Default)
```
Get-HuduAssetLayouts [-Name <String>] [-Slug <String>] [-StartDate <DateTime>] [-EndDate <DateTime>]
 [-ExactDate <DateTime>] [<CommonParameters>]
```

### Single
```
Get-HuduAssetLayouts [-LayoutId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Call Hudu API to retrieve asset layouts for server

## EXAMPLES

### EXAMPLE 1
```
Get-HuduAssetLayouts -Name 'Contacts'
```

## PARAMETERS

### -Name
Filter by name of Asset Layout

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

### -LayoutId
Id of Asset Layout

```yaml
Type: Int32
Parameter Sets: Single
Aliases: id, layout_id

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by url slug

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
