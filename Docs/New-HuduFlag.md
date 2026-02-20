---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduFlag

## SYNOPSIS
Creates a Flag on a Hudu object (asset, website, article, etc.).

## SYNTAX

```
New-HuduFlag [-FlagTypeId] <Int32> [[-Description] <String>] [-Flagable_Type] <String> [-flagable_id] <Int32>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Flag record in Hudu by associating a Flag Type with a specific object
(e.g., a Company, Asset, Network, VLAN).
Use FlagTypeId to choose the flag style/color,
and Flagable_Type + Flagable_Id to point at the target object.

## EXAMPLES

### EXAMPLE 1
```
# Flag company 123 with flag type 5
New-HuduFlag -FlagTypeId 5 -Flagable_Type Company -flagable_id 123 -Description "Contract renewal due"
```

### EXAMPLE 2
```
# Flag asset 88 with flag type 2
New-HuduFlag -FlagTypeId 2 -Flagable_Type Asset -flagable_id 88
```

## PARAMETERS

### -FlagTypeId
The ID of the Flag Type to apply.
Use Get-HuduFlagTypes to discover IDs.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Optional note shown on the flag.
Useful for context like "Needs review" or "Decommission pending".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Flagable_Type
The type of object to attach the flag to (e.g., Company, Asset, Website, Network).
This value is normalized to Hudu's canonical flagable_type before the request is sent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: flaggabletype, flaggable_type, flagabletype, Flag_type, FlagType

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -flagable_id
The ID of the target object (matching Flagable_Type).
For example, a Company ID if Flagable_Type is Company.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FlaggableId, flaggable_id, flagableid

Required: True
Position: 4
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
API Endpoint: POST /api/v1/flags
Requires Hudu API access configured for Invoke-HuduRequest.

## RELATED LINKS
