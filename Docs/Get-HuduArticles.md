---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduArticles

## SYNOPSIS
Get Knowledge Base Articles

## SYNTAX

```
Get-HuduArticles [[-Id] <Int32>] [[-CompanyId] <Int32>] [[-Name] <String>] [[-Slug] <String>]
 [[-UpdatedAfter] <DateTime>] [[-UpdatedBefore] <DateTime>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve KB articles by Id or a list

## EXAMPLES

### EXAMPLE 1
```
Get-HuduArticles -Name 'Article name'
get-huduarticles -UpdatedAfter $(get-date).AddDays(-3)
```

## PARAMETERS

### -Id
Id of the Article

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Filter by company id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Filter by name of article

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

### -Slug
Filter by slug of article

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

### -UpdatedAfter
Get articles Updated After X datetime

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedBefore
Get articles Updated Before Y datetime

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
