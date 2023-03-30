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

```
Get-HuduAssets [[-Id] <Int32>] [[-AssetLayoutId] <Int32>] [[-AssetLayout] <String>] [[-CompanyId] <Int32>]
 [[-Name] <String>] [-Archived] [[-PrimarySerial] <String>] [[-Slug] <String>] [[-Search] <String>]
 [<CommonParameters>]
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetLayoutId
Id of the requested asset layout

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: asset_layout_id

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetLayout
Name of the requested asset layout

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

### -CompanyId
Id of the requested company

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Filter by name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archived
Show archived results

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases: primary_serial

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by slug

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Search
Filter by search terms

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
