---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Remove-HuduFlag

## SYNOPSIS
Deletes a Flag.

## SYNTAX

```
Remove-HuduFlag [-Id] <Int32> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a Flag by ID.
This is destructive and cannot be undone (unless Hudu provides recovery).
Supports ShouldProcess for -WhatIf / -Confirm.

## EXAMPLES

### EXAMPLE 1
```
Remove-HuduFlag -Id 77
```

### EXAMPLE 2
```
Get-HuduFlags -flagable_type Company -flagable_id 123 | Remove-HuduFlag -WhatIf
```

## PARAMETERS

### -Id
The Flag ID to delete.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FlagId

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
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
API Endpoint: DELETE /api/v1/flags/{id}

## RELATED LINKS
