---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduRelations

## SYNOPSIS
Get a list of relations.

## SYNTAX

```
Get-HuduRelations [[-FromableType] <String>] [[-FromableId] <Int32>] [[-ToableType] <String>]
 [[-ToableId] <Int32>] [[-IsInverse] <Boolean>] [[-Description] <String>] [[-CreatedAt] <String>]
 [[-CreatedAfter] <DateTime>] [[-CreatedBefore] <DateTime>] [[-UpdatedAt] <String>]
 [[-UpdatedAfter] <DateTime>] [[-UpdatedBefore] <DateTime>] [[-Page] <Int32>] [[-PageSize] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to retrieve object relationships with optional filtering.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduRelations -FromableType Asset -FromableId 123
```

### EXAMPLE 2
```
Get-HuduRelations -ToableType Company -ToableId 42 -IsInverse $false
```

### EXAMPLE 3
```
Get-HuduRelations -CreatedAfter ([datetime]'2026-08-01') -UpdatedBefore ([datetime]'2026-08-07')
```

## PARAMETERS

### -FromableType
Filter by the FROM record type.

```yaml
Type: String
Parameter Sets: (All)
Aliases: fromable_type

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FromableId
Filter by the FROM record ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: fromable_id

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToableType
Filter by the TO record type.

```yaml
Type: String
Parameter Sets: (All)
Aliases: toable_type

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToableId
Filter by the TO record ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: toable_id

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsInverse
Filter by whether the relation is the inverse side.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: is_inverse

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Filter by description.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedAt
Filter by creation date using the raw API value (YYYY-MM-DD, ISO datetime, or API-supported range string).

```yaml
Type: String
Parameter Sets: (All)
Aliases: created_at

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedAfter
Start datetime for the created_at range.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedBefore
End datetime for the created_at range.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedAt
Filter by update date using the raw API value (YYYY-MM-DD, ISO datetime, or API-supported range string).

```yaml
Type: String
Parameter Sets: (All)
Aliases: updated_at

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedAfter
Start datetime for the updated_at range.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedBefore
End datetime for the updated_at range.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
Return a specific page instead of auto-paginating all results.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageSize
Number of results per page.
Defaults to 1000 when auto-paginating.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: page_size

Required: False
Position: 14
Default value: 1000
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
