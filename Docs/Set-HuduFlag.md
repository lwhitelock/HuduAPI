---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduFlag

## SYNOPSIS
Update a flag

## SYNTAX

```
Set-HuduFlag [-Id] <Int32> [[-FlagTypeId] <Int32>] [[-Description] <String>] [[-Flagable_Type] <String>]
 [[-flagable_id] <Int32>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to update a Flag.
If updating the flagable association,
flagable_type must be valid and the record must exist.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduFlag -Id 10 -Description "Updated flag description" -FlagTypeId 2
```

### EXAMPLE 2
```
Set-HuduFlag -Id 10 -flagable_type Asset -flagable_id 123
```

## PARAMETERS

### -Id
ID of the flag to update

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FlagId, flag_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FlagTypeId
Updated flag type ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: flag_type_id, flagType_Id

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Updated description

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

### -Flagable_Type
Updated flagable type (Asset, Website, Article, AssetPassword, Company, Procedure, RackStorage, Network, IpAddress, Vlan, VlanZone)

```yaml
Type: String
Parameter Sets: (All)
Aliases: flaggabletype, flaggable_type, flagabletype, Flag_type, FlagType

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -flagable_id
Updated flagable record ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FlaggableId, flaggable_id, flagableid

Required: False
Position: 5
Default value: 0
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
