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

### List (Default)
```
Get-HuduWebsites [-Name <String>] [-Slug <String>] [-Search <String>] [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-ExactDate <DateTime>] [<CommonParameters>]
```

### Single
```
Get-HuduWebsites [-WebsiteId <Int32>] [<CommonParameters>]
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
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebsiteId
{{ Fill WebsiteId Description }}

```yaml
Type: Int32
Parameter Sets: Single
Aliases: website_id

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by url slug

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Search
Fitler by search query

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
Filter by updated_at property

```yaml
Type: DateTime
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
Filter by updated_at property

```yaml
Type: DateTime
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExactDate
Filter by updated_at property

```yaml
Type: DateTime
Parameter Sets: List
Aliases:

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
