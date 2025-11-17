---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduObjectByUrl

## SYNOPSIS
Get Hudu object from URL

## SYNTAX

```
Get-HuduObjectByUrl [[-Url] <Uri>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve object based on URL string

## EXAMPLES

### EXAMPLE 1
```
Get-HuduObject -Url https://your-hudu-server/a/some-asset-1z8z7a
```

## PARAMETERS

### -Url
Url to retrieve object from

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
