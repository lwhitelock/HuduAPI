---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduRackStorages

## SYNOPSIS
Get a list of Rack Storages or provide ID to get a single rack storage

## SYNTAX

```
Get-HuduRackStorages [[-Id] <Int32>] [[-CompanyId] <Int32>] [[-LocationId] <Int32>] [[-Height] <Int32>]
 [[-MinWidth] <Int32>] [[-MaxWidth] <Int32>] [[-CreatedAfter] <DateTime>] [[-CreatedBefore] <DateTime>]
 [[-UpdatedAfter] <DateTime>] [[-UpdatedBefore] <DateTime>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve rack storage items with filters like asset ID, role, side, etc.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduRackStorages -CompanyId 42 -MinWidth 600 -MaxWidth 800
```

Returns racks for company ID 42 with widths between 600 and 800.

## PARAMETERS

### -Id
ID of the Rack Storage to get

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
Filter Rack Storages by Company Id

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

### -LocationId
Filter Rack Storages by Location Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Height
Filter Rack Storages by available storage height

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinWidth
Filter Rack Storages by minimum available storage width

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

### -MaxWidth
Filter Rack Storages by maximum available storage width

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedAfter
Start datetime for created_at range

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedBefore
End datetime for created_at range

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

### -UpdatedAfter
Start datetime for updated_at range

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

### -UpdatedBefore
End datetime for updated_at range

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
API Endpoint: GET /api/v1/rack_storages

\>

## RELATED LINKS
