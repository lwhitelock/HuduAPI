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
New-HuduRackStorageItem [-RackStorageId] <Int32> [-RackStorageRoleId] <Int32> [-AssetId] <Int32>
 [-StartUnit] <Int32> [-EndUnit] <Int32> [-Status] <Int32> [-Side] <Int32> [[-MaxWattage] <Int32>]
 [[-PowerDraw] <Int32>] [[-ReservedMessage] <String>] [-CompanyId] <Int32> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to create a new rack storage item

## EXAMPLES

### EXAMPLE 1
```
New-HuduRackStorageItem -AssetId 123 -RackStorageRoleId 45 -StartUnit 1 -EndUnit 4 -Status 1 -Side "Front"
```

Creates a new rack storage item (for asset id 123) designated for rack storage item role id of 45, from unit 1-4 on front of rack storage

## PARAMETERS

### -RackStorageId
{{ Fill RackStorageId Description }}

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

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
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

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Integer status code for the rack storage item.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Side
Rack side: 1 or 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: 0
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
Company ID to associate with the rack item.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
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

## RELATED LINKS
