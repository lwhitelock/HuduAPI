---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduVLANZone

## SYNOPSIS
Create a new VLAN Zone in Hudu.

## SYNTAX

```
New-HuduVLANZone [-Name] <String> [-CompanyId] <Int32> [[-VLANIdRanges] <String>] [[-Description] <String>]
 [[-Archived] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a VLAN Zone under a specified company, with VLAN Id ranges and optional description. 
VLAN ranges must be expressed as "start-end" and may be comma-separated.

## EXAMPLES

### EXAMPLE 1
```
New-HuduVLANZone -Name "East Coast Zone" -CompanyId 1 -VLANIdRanges "200-300" -Description "Datacenter VLANs"
```

## PARAMETERS

### -Name
The name of the VLAN Zone.

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
The company identifier to associate with this VLAN Zone.

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

### -VLANIdRanges
VLAN Id ranges string (e.g.
"1-4", "200-300,400-450").

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

### -Description
Optional description text.

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

### -Archived
Whether the VLAN Zone should be archived upon creation ("true"/"false").
Defaults to "false".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
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
