---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduLabels

## SYNOPSIS
Gets Labels from Hudu.

## SYNTAX

### List (Default)
```
Get-HuduLabels [-LabelTypeId <Int32>] [-Labelable_Type <String>] [-Labelable_Id <Int32>] [-UserId <Int32>]
 [-CreatedAt <String>] [-UpdatedAt <String>] [-Page <Int32>] [-PageSize <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ById
```
Get-HuduLabels [-Id <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves a single Label by ID, or lists Labels with optional filtering by label
type, target record, user, and created/updated dates.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduLabels
```

### EXAMPLE 2
```
Get-HuduLabels -LabelTypeId 5
```

### EXAMPLE 3
```
Get-HuduLabels -Labelable_Type Asset -Labelable_Id 123
```

### EXAMPLE 4
```
Get-HuduLabels -Id 77
```

## PARAMETERS

### -Id
Return a single Label by ID.

```yaml
Type: Int32
Parameter Sets: ById
Aliases: LabelId, label_id

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LabelTypeId
Filter labels by Label Type ID.

```yaml
Type: Int32
Parameter Sets: List
Aliases: label_type_id, labeltype_id, label_typeid, label_type, type_id, typeid

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labelable_Type
Filter by the target object type the label is attached to.

```yaml
Type: String
Parameter Sets: List
Aliases: object_type, objectType, target_type, targetType

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labelable_Id
Filter by the target object ID the label is attached to.

```yaml
Type: Int32
Parameter Sets: List
Aliases: object_id, objectID, target_id, targetId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId
Filter by the ID of the user who applied the label.

```yaml
Type: Int32
Parameter Sets: List
Aliases: user_id

Required: False
Position: Named
Default value: 0
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
- GET /api/v1/labels
- GET /api/v1/labels/{id}

## RELATED LINKS
