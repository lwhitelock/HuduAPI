---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduRelation

## SYNOPSIS
Create a Relation

## SYNTAX

```
New-HuduRelation [[-Description] <String>] [-FromableType] <String> [[-FromableID] <Int32>]
 [[-ToableType] <String>] [[-ToableID] <Int32>] [[-IsInverse] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to create relationships between objects

## EXAMPLES

### EXAMPLE 1
```
An example
```

## PARAMETERS

### -Description
Give a description to the relation so you know why two things are related

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

### -FromableType
The type of the FROM relation (Asset, Website, Procedure, AssetPassword, Company, Article)

```yaml
Type: String
Parameter Sets: (All)
Aliases: fromable_type

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FromableID
The ID of the FROM relation

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: fromable_id

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToableType
The type of the TO relation (Asset, Website, Procedure, AssetPassword, Company, Article)

```yaml
Type: String
Parameter Sets: (All)
Aliases: toable_type

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToableID
The ID of the TO relation

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: toable_id

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsInverse
When a relation is created, it will also create another relation that is the inverse.
When this is true, this relation is the inverse.

```yaml
Type: String
Parameter Sets: (All)
Aliases: is_inverse

Required: False
Position: 6
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
