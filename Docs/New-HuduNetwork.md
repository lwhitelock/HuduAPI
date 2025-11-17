---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduNetwork

## SYNOPSIS
Create a new Hudu network.

## SYNTAX

```
New-HuduNetwork [-Name] <String> [-Address] <String> [-CompanyId] <Int32> [[-LocationId] <Int32>]
 [[-Description] <String>] [[-NetworkType] <Int32>] [[-VlanId] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new hudu IPAM Network Object for a Company.
Name, Address (or CIDR Address Range) and CompanyId are required.
Returns the created network object on success, or $null on failure.

## EXAMPLES

### EXAMPLE 1
```
New-HuduNetwork -Name "Core LAN" -Address "192.168.10.0/24" -CompanyId 42
```

### EXAMPLE 2
```
New-HuduNetwork -Name "Server VLAN 30" -Address "10.20.30.0/24" -CompanyId 42 -LocationId 7 -VlanId 30 -NetworkType 1
```

## PARAMETERS

### -Name
Display name for the network.
(Required)

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

### -Address
CIDR notation for the network (e.g.
10.0.0.0/24).
(Required)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Company ID to associate with the network.
(Required)

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

### -LocationId
Optional location ID to associate with the network.

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

### -Description
Free-form description of the network.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
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
Position: 7
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
