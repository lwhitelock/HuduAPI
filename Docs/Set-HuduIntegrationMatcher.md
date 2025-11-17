---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduIntegrationMatcher

## SYNOPSIS
Update a Matcher

## SYNTAX

### AcceptSuggestedMatch
```
Set-HuduIntegrationMatcher -Id <String> [-AcceptSuggestedMatch] [-PotentialCompanyId <String>]
 [-SyncId <String>] [-Identifier <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SetCompanyId
```
Set-HuduIntegrationMatcher -Id <String> -CompanyId <String> [-PotentialCompanyId <String>] [-SyncId <String>]
 [-Identifier <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to set integration matchers

## EXAMPLES

### EXAMPLE 1
```
Set-HuduIntegrationMatcher -Id 1 -AcceptSuggestedMatch
```

## PARAMETERS

### -Id
Id of the requested matcher

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AcceptSuggestedMatch
Set the Sync Id/Identifier to the suggested one

```yaml
Type: SwitchParameter
Parameter Sets: AcceptSuggestedMatch
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Requested company id to match

```yaml
Type: String
Parameter Sets: SetCompanyId
Aliases: company_id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PotentialCompanyId
Potential company id to match

```yaml
Type: String
Parameter Sets: (All)
Aliases: potential_company_id

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SyncId
Sync id to match

```yaml
Type: String
Parameter Sets: (All)
Aliases: sync_id

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Identifier
Identifier to match

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

## RELATED LINKS
