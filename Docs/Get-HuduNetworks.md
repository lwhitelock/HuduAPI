---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduNetworks

## SYNOPSIS
Retrieve Hudu network by ID or networks.

## SYNTAX

```
Get-HuduNetworks [[-Id] <Int32>] [[-CompanyId] <Int32>] [[-Slug] <String>] [[-Name] <String>]
 [[-NetworkType] <Int32>] [[-Address] <String>] [[-LocationID] <Int32>] [[-Archived] <Boolean>]
 [[-CreatedAfter] <DateTime>] [[-CreatedBefore] <DateTime>] [[-UpdatedAfter] <DateTime>]
 [[-UpdatedBefore] <DateTime>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Gets a single network by ID, or lists networks filtered by one or more criteria.
When -Id is provided, performs GET /api/v1/networks/{id}.
Otherwise performs
GET /api/v1/networks with query parameters built from the provided filters.
Supports created/updated date range filtering via Convert-ToHuduDateRange.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduNetworks -Id 123
```

### EXAMPLE 2
```
Get-HuduNetworks -CompanyId 42 -LocationId 7 -Archived $false
```

### EXAMPLE 3
```
Get-HuduNetworks -CreatedAfter ([datetime]'2025-08-01') -UpdatedBefore ([datetime]'2025-08-15')
```

## PARAMETERS

### -Id
Network ID.
When supplied, returns only that network.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Filter by company ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by slug.

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

### -Name
Filter by network name (exact match as supported by the API).

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

### -NetworkType
Filter by numeric network type.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Address
Filter by CIDR/address string.

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

### -LocationID
Filter by location ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archived
Filter archived state (True/False).

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedAfter
Only include networks created on or after this date/time.

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

### -CreatedBefore
Only include networks created on or before this date/time.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedAfter
Only include networks updated on or after this date/time.

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
Only include networks updated on or before this date/time.

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
