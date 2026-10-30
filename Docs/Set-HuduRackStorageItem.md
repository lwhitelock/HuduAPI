---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduRackStorageItem

## SYNOPSIS
Update an existing Rack Storage Item in Hudu.

## SYNTAX

```
Set-HuduRackStorageItem [-Id] <Int32> [[-RackStorageRoleId] <Int32>] [[-AssetId] <Int32>]
 [[-StartUnit] <Int32>] [[-EndUnit] <Int32>] [[-Status] <Int32>] [[-Side] <String>] [[-MaxWattage] <Int32>]
 [[-PowerDraw] <Int32>] [[-ReservedMessage] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to update a Rack Storage Item using its ID.
You can modify any of the properties such as associated asset, rack units, power draw, and reserved message.
Only explicitly supplied properties are sent.
Omitted properties retain their existing values.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduRackStorageItem -Id 456 -StartUnit 10 -EndUnit 15 -Side "Rear" -PowerDraw 120
```

Updates the Rack Storage Item 456 to span units 10-15 on the rear side and sets its power draw to 120W.

## PARAMETERS

### -Id
The ID of the Rack Storage Item to update.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RackStorageRoleId
The ID of the Rack Storage Role to associate with this item.

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
The ID of the Asset to associate with this rack slot.

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
The rack unit where this asset begins (e.g., 1 for top of rack).

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
The rack unit where this asset ends.

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
A numeric status code for the rack item (0 for reserved, 1 for used).
Omit to leave unchanged.

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
Rack side: Front (0) or Rear (1).
Accepts names or numbers.
Omit to leave unchanged.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxWattage
The maximum power capacity allowed for this item.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerDraw
The actual power draw of the asset, in watts.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReservedMessage
A text message displayed when the item is reserved.
Use an empty string to clear it.

```yaml
Type: String
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
API Endpoint: PUT /api/v1/rack_storage_items/{id}

## RELATED LINKS
