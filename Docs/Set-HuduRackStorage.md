---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduRackStorage

## SYNOPSIS
Update an existing Rack Storage in Hudu.

## SYNTAX

```
Set-HuduRackStorage [-Id] <Int32> [[-Name] <String>] [[-CompanyId] <Int32>] [[-Height] <Int32>]
 [[-Width] <Int32>] [[-LocationId] <Int32>] [[-Description] <String>] [[-MaxWattage] <Int32>]
 [[-StartingUnit] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to update a Rack Storage by ID.
You can update any subset of properties including name, dimensions, company, or location.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduRackStorage -Id 123 -Name "Rack A-02" -Height 45
```

Updates Rack Storage 123 to be renamed "Rack A-02" with 45U height.

## PARAMETERS

### -Id
ID of the Rack Storage to update.

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

### -Name
Updated name for the Rack Storage.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Updated company ID associated with the Rack Storage.

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
The new height in rack units (U).

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

### -Width
The new width of the rack.

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

### -LocationId
Updated location ID for the Rack Storage.

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

### -Description
Optional updated description for the Rack Storage.

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
Maximum power rating (watts) for the updated Rack Storage.

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

### -StartingUnit
The new starting rack unit number.

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
API Endpoint: PUT /api/v1/rack_storages/{id}

## RELATED LINKS
