---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Remove-HuduFlagType

## SYNOPSIS
Deletes a Flag Type.

## SYNTAX

```
Remove-HuduFlagType [-Id] <Int32> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes a Flag Type by ID.
This may fail if the Flag Type is in use by existing Flags.
Supports ShouldProcess for -WhatIf / -Confirm.

## EXAMPLES

### EXAMPLE 1
```
Remove-HuduFlagType -Id 12
```

### EXAMPLE 2
```
Remove-HuduFlagType -Id 12 -WhatIf
```

## PARAMETERS

### -Id
The Flag Type ID to delete.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FlagTypeId

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
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
API Endpoint: DELETE /api/v1/flag_types/{id}

## RELATED LINKS
