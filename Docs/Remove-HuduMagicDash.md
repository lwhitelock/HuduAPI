---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Remove-HuduMagicDash

## SYNOPSIS
Delete a Magic Dash Item

## SYNTAX

### Id (Default)
```
Remove-HuduMagicDash -Id <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### TitleCompany
```
Remove-HuduMagicDash -Title <String> -CompanyName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to remove Magic Dash by Id or Title and Company Name

## EXAMPLES

### EXAMPLE 1
```
Remove-HuduMagicDash -Id 1
```

### EXAMPLE 2
```
Remove-HuduMagicDash -Title 'Microsoft 365' -CompanyName 'AcmeCorp'
```

## PARAMETERS

### -Title
Title of the Magic Dash

```yaml
Type: String
Parameter Sets: TitleCompany
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CompanyName
Company Name

```yaml
Type: String
Parameter Sets: TitleCompany
Aliases: company_name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Id of the Magic Dash

```yaml
Type: Int32
Parameter Sets: Id
Aliases:

Required: True
Position: Named
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
