---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduWebsites

## SYNOPSIS
Get a list of all websites

## SYNTAX

```
Get-HuduWebsites [[-Name] <String>] [[-WebsiteId] <Int32>] [[-Slug] <String>] [[-Search] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to get websites

## EXAMPLES

### EXAMPLE 1
```
Get-HuduWebsites -Search 'domain.com'
```

## PARAMETERS

### -Name
Filter websites by name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebsiteId
{{ Fill WebsiteId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: website_id

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by url slug

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Search
Fitler by search query

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
