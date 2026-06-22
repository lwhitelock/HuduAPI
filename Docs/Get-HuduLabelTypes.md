---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduLabelTypes

## SYNOPSIS
Gets Label Types from Hudu.

## SYNTAX

### List (Default)
```
Get-HuduLabelTypes [-Name <String>] [-Color <String>] [-Slug <String>] [-CreatedAt <String>]
 [-UpdatedAt <String>] [-Page <Int32>] [-PageSize <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### ById
```
Get-HuduLabelTypes [-Id <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves Label Types by ID or lists Label Types with optional filtering.
When
listing, filters match exact values for name/color/slug when provided.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduLabelTypes
```

### EXAMPLE 2
```
Get-HuduLabelTypes -Name "Critical"
```

### EXAMPLE 3
```
Get-HuduLabelTypes -Id 12
```

## PARAMETERS

### -Id
Return a single Label Type by ID.

```yaml
Type: Int32
Parameter Sets: ById
Aliases: LabelTypeId, label_type_id, labeltype_id, label_typeid, type_id, typeid

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Filter by exact Label Type name.

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

### -Color
Filter by exact color value, such as #0000ff.

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

### -Slug
Filter by exact slug value.

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

### -CreatedAt
Filter by creation date (YYYY-MM-DD or ISO datetime).

```yaml
Type: String
Parameter Sets: List
Aliases: created_at

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedAt
Filter by update date (YYYY-MM-DD or ISO datetime).

```yaml
Type: String
Parameter Sets: List
Aliases: updated_at

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
Return a specific page instead of auto-paginating all results.

```yaml
Type: Int32
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageSize
Number of results per page.
Defaults to 1000 when auto-paginating.

```yaml
Type: Int32
Parameter Sets: List
Aliases: page_size

Required: False
Position: Named
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
API Endpoints:
- GET /api/v1/label_types
- GET /api/v1/label_types/{id}

## RELATED LINKS
