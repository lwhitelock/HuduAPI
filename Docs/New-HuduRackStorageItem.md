---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduRackStorageItem

## SYNOPSIS
Creates a new Rack Storage Item in Hudu.

## SYNTAX

```
New-HuduRackStorageItem [-RackStorageId] <Int32> [-RackStorageRoleId] <Int32> [[-AssetId] <Int32>]
 [-StartUnit] <Int32> [[-EndUnit] <Int32>] [[-Status] <Int32>] [[-Side] <String>] [[-MaxWattage] <Int32>]
 [[-PowerDraw] <Int32>] [[-ReservedMessage] <String>] [[-CompanyId] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a rack storage item.
Defaults to the front side and a single rack unit.
When Status is omitted, items with an asset are used (1) and items without an asset are reserved (0).

## EXAMPLES

### EXAMPLE 1
```
New-HuduRackStorageItem -RackStorageId 10 -AssetId 123 -RackStorageRoleId 45 -StartUnit 1 -EndUnit 4
```

Creates a new rack storage item (for asset id 123) designated for rack storage item role id of 45, from unit 1-4 on front of rack storage

### EXAMPLE 2
```
New-HuduRackStorageItem -RackStorageId 10 -RackStorageRoleId 45 -StartUnit 5 -ReservedMessage 'Future server'
```

Reserves unit 5 on the front of rack 10 without requiring an asset or company ID.

## PARAMETERS

### -RackStorageId
The ID of the rack that will contain this item.

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
The ID of the rack storage role.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetId
The ID of the asset to associate.
Omit for a reservation without a linked asset.

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
The starting rack unit.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndUnit
The ending rack unit.
Defaults to StartUnit for a single-unit item.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: $StartUnit
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Status code: 0 for reserved, 1 for used.
Defaults to 1 when AssetId is supplied and nonzero, otherwise 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: $(if ($AssetId) { 1 } else { 0 })
Accept pipeline input: False
Accept wildcard characters: False
```

### -Side
Rack side: Front (0) or Rear (1).
Accepts names or numbers and defaults to Front.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Front
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxWattage
Max wattage allowed in the rack section.

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
Power draw for the asset in watts.

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
Optional reserved message for placeholder items.

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

### -CompanyId
Optional company ID, retained for compatibility.
Only sent when explicitly supplied.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
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
API Endpoint: POST /api/v1/rack_storage_items

## RELATED LINKS
