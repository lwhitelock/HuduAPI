---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduLabel

## SYNOPSIS
Creates a Label on a Hudu record.

## SYNTAX

```
New-HuduLabel [-LabelTypeId] <Int32> [-Labelable_Type] <String> [-Labelable_Id] <Int32>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Label record in Hudu by associating a Label Type with a specific
record.
The Label Type must be applicable to the target record type.

## EXAMPLES

### EXAMPLE 1
```
New-HuduLabel -LabelTypeId 5 -Labelable_Type Asset -Labelable_Id 123
```

## PARAMETERS

### -LabelTypeId
The ID of the Label Type to apply.
Use Get-HuduLabelTypes to discover IDs.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: label_type_id, labeltype_id, label_typeid, label_type, type_id, typeid

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labelable_Type
The type of object to attach the label to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: object_type, objectType, target_type, targetType

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labelable_Id
The ID of the target object matching Labelable_Type.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: object_id, objectID, target_id, targetId

Required: True
Position: 3
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
API Endpoint: POST /api/v1/labels

## RELATED LINKS
