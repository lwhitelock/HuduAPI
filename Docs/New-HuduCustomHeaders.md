---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduCustomHeaders

## SYNOPSIS
Set Hudu custom headers to be injected into each request

## SYNTAX

```
New-HuduCustomHeaders [-Headers] <Hashtable> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
There may be times when one might need to use custom headers e.g.
Service Tokens for Cloudflare Zero Trust

## EXAMPLES

### EXAMPLE 1
```
New-HuduCustomHeaders -Headers @{"CF-Access-Client-Id" = "x"; "CF-Access-Client-Secret" = "y"}
```

## PARAMETERS

### -Headers
Hashtable with the Custom Headers that need to be injected into each request

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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
General notes

## RELATED LINKS
