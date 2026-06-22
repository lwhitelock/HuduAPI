---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduLabel

## SYNOPSIS
Updates a Label.

## SYNTAX

```
Set-HuduLabel [-Id] <Int32> [[-LabelTypeId] <Int32>] [[-Labelable_Type] <String>] [[-Labelable_Id] <Int32>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Label by ID.
The same applicability and uniqueness rules as creation apply.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduLabel -Id 10 -Labelable_Type Asset -Labelable_Id 456
```

### EXAMPLE 2
```
Set-HuduLabel -Id 10 -LabelTypeId 2
```

## PARAMETERS

### -Id
ID of the Label to update.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: LabelId, label_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LabelTypeId
Updated Label Type ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: label_type_id, labeltype_id, label_typeid, label_type, type_id, typeid

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labelable_Type
Updated target record type.

```yaml
Type: String
Parameter Sets: (All)
Aliases: object_type, objectType, target_type, targetType

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labelable_Id
Updated target record ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: object_id, objectID, target_id, targetId

Required: False
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
API Endpoint: PUT /api/v1/labels/{id}

## RELATED LINKS
