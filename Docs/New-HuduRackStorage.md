---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduRackStorage

## SYNOPSIS
Creates a new Rack Storage in Hudu.

## SYNTAX

```
New-HuduRackStorage [-Name] <String> [-CompanyId] <Int32> [-Height] <Int32> [-Width] <Int32>
 [[-LocationId] <Int32>] [[-Description] <String>] [[-MaxWattage] <Int32>] [[-StartingUnit] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Sends a request to the Hudu API to create a new Rack Storage, including properties such as name, dimensions, location, and associated company.

## EXAMPLES

### EXAMPLE 1
```
New-HuduRackStorage -Name "Rack A-01" -LocationId 12 -CompanyId 34 -Height 42 -StartingUnit 1
```

Creates a new rack called "Rack A-01" at location ID 12, linked to company ID 34, with 42U height starting from unit 1.

### EXAMPLE 2
```
Get-HuduRackStorage -Id 101
```

Returns the Rack Storage with ID 101.

## PARAMETERS

### -Name
The name of the new rack (e.g., "Rack A-01").
This is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
The ID of the company associated with the rack.
Optional, but useful for filtering.

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

### -Height
Total number of rack units (U) in height (e.g., 42 for a standard rack).
Optional.

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

### -Width
The width of the rack in millimeters or another defined unit (depending on Hudu's expected units).
Optional.

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

### -LocationId
The ID of the location where this rack is physically installed.
Optional.

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

### -Description
A brief description or note for the rack (e.g., "Primary server rack").
Optional.

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

### -MaxWattage
The maximum wattage supported by the rack.
Optional.

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

### -StartingUnit
The starting rack unit number (e.g., 1 if it's a full rack).
Optional.

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
API Endpoint: GET /api/v1/rack_storages/{id}

## RELATED LINKS
