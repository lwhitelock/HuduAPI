---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduNetwork

## SYNOPSIS
Update a Hudu network.

## SYNTAX

```
Set-HuduNetwork [-Id] <Int32> [[-Name] <String>] [[-Address] <String>] [[-CompanyId] <Int32>]
 [[-LocationId] <Int32>] [[-Description] <String>] [[-NetworkType] <Int32>] [[-VlanId] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Updates a Hudu IPAM Network object for a Company.
Returns the updated network object on success, or $null on failure.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduNetwork -Id 123 -Name "Core LAN" -Description "Primary office network"
```

### EXAMPLE 2
```
Set-HuduNetwork -Id 123 -Address "10.20.30.0/24" -VlanId 30 -LocationId 456
```

## PARAMETERS

### -Id
The unique network ID to update.
(Required)

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
New name for the network.

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

### -Address
CIDR notation for the network (e.g.
192.168.10.0/24).

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

### -CompanyId
Company ID to associate with the network.

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

### -LocationId
Location ID to associate with the network.

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
Free-form description of the network.

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

### -NetworkType
Numeric network type as used by Hudu (module/API enum value).

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

### -VlanId
VLAN identifier for the network.

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

## RELATED LINKS
