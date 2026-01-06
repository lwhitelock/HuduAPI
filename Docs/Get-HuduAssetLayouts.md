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

```
Get-HuduAssetLayouts [[-Name] <String>] [[-LayoutId] <Int32>] [[-Slug] <String>] [[-UpdatedAfter] <DateTime>]
 [[-UpdatedBefore] <DateTime>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Call Hudu API to retrieve asset layouts for server

## EXAMPLES

### EXAMPLE 1
```
Get-HuduAssetLayouts -Name 'Contacts'
Get-HuduAssetLayouts -UpdatedBefore $(get-date).AddDays(-3)
```

## PARAMETERS

### -Name
Filter by name of Asset Layout

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

### -LayoutId
Id of Asset Layout

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: id, layout_id

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by url slug

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

### -UpdatedAfter
Get asset layouts Updated After X datetime

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedBefore
Get asset layouts Updated Before Y datetime

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
