---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduRackStorageItems

## SYNOPSIS
Provide a rack storage item id to Get a single rack storage item, otherwise Get a list of Rack Storage Items

## SYNTAX

```
Get-HuduRackStorageItems [[-Id] <Int32>] [[-RoleId] <Int32>] [[-AssetId] <Int32>] [[-StartUnit] <Int32>]
 [[-EndUnit] <Int32>] [[-Status] <Int32>] [[-Side] <Int32>] [[-CreatedAfter] <DateTime>]
 [[-CreatedBefore] <DateTime>] [[-UpdatedAfter] <DateTime>] [[-UpdatedBefore] <DateTime>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve rack storage items with filters like asset ID, role, side, etc.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduRackStorageItems -RoleId 12 -Side 'Front'
```

Returns all front-facing rack items associated with role ID 12.

## PARAMETERS

### -Id
{{ Fill Id Description }}

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

### -RoleId
Filter by Rack Storage Role ID

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

### -AssetId
Filter by Asset ID

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

### -StartUnit
Filter by Start Unit

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

### -EndUnit
Filter by End Unit

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

### -Status
Filter by Status

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

### -Side
Filter by Side (0='Front' or 1='Rear')

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

### -CreatedAfter
Start datetime for created_at range

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
End datetime for created_at range

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

### -UpdatedAfter
Start datetime for updated_at range

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

### -UpdatedBefore
End datetime for updated_at range

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
API Endpoint: GET /api/v1/rack_storage_items

## RELATED LINKS
