---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduAssetLayoutFieldID

## SYNOPSIS
Get Hudu Asset Layout Field ID

## SYNTAX

```
Get-HuduAssetLayoutFieldID [-Name] <String> [-LayoutId] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Retrieves ID for Hudu Asset Layout Fields

## EXAMPLES

### EXAMPLE 1
```
Get-HuduAssetLayoutFieldID -Name 'Extra Info' -LayoutId 1
```

## PARAMETERS

### -Name
Name of Field

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

### -LayoutId
Asset Layout Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: asset_layout_id

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
