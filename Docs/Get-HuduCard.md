---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduCard

## SYNOPSIS
Get Integration Cards

## SYNTAX

```
Get-HuduCard [-IntegrationSlug] <String> [[-IntegrationId] <String>] [[-IntegrationIdentifier] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lookup cards with outside integration details

## EXAMPLES

### EXAMPLE 1
```
Get-HuduCard -IntegrationSlug cw_manage -IntegrationId 1
```

## PARAMETERS

### -IntegrationSlug
Identifier of outside integration

```yaml
Type: String
Parameter Sets: (All)
Aliases: integration_slug

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IntegrationId
ID in the integration.
Must be present, unless integration_identifier is set

```yaml
Type: String
Parameter Sets: (All)
Aliases: integration_id

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IntegrationIdentifier
Identifier in the integration (if integration_id is not set)

```yaml
Type: String
Parameter Sets: (All)
Aliases: integration_identifier

Required: False
Position: 3
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
