---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Remove-HuduPasswordFolder

## SYNOPSIS
Delete a PasswordFolder by ID

## SYNTAX

```
Remove-HuduPasswordFolder [-Id] <Int32> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to remove passwordfolder

## EXAMPLES

### EXAMPLE 1
```
Remove-HuduPasswordFolder -Id 1
```

## PARAMETERS

### -Id
Id of the passwordfolder

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
