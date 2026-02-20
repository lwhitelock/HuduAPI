---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduFlagTypes

## SYNOPSIS
Gets Flag Types from Hudu.

## SYNTAX

### List (Default)
```
Get-HuduFlagTypes [-Name <String>] [-Color <String>] [-Slug <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### ById
```
Get-HuduFlagTypes [-Id <Int32>] [-Color <String>] [-Slug <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves Flag Types by ID or lists Flag Types with optional filtering.
When listing,
filters match exact values for name/color/slug when provided.
Results are paginated.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduFlagTypes
# List all flag types
```

### EXAMPLE 2
```
Get-HuduFlagTypes -Name "Security Risk"
# Find the "Security Risk" flag type
```

### EXAMPLE 3
```
Get-HuduFlagTypes -Id 12
# Get a specific flag type by ID
```

## PARAMETERS

### -Id
Return a single Flag Type by ID.

```yaml
Type: Int32
Parameter Sets: ById
Aliases: FlagTypeId, flag_type_id

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Filter by exact Flag Type name.

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
Filter by exact color value (canonicalized to Hudu).

```yaml
Type: String
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

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
API Endpoints:
- GET /api/v1/flag_types
- GET /api/v1/flag_types/{id}

## RELATED LINKS
