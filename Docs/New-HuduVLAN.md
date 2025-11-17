---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduVLAN

## SYNOPSIS
Create a new VLAN in Hudu.

## SYNTAX

```
New-HuduVLAN [-Name] <String> [-CompanyId] <Int32> [-VLANId] <Int32> [[-Description] <String>]
 [[-RoleListItemID] <Int32>] [[-StatusListItemID] <Int32>] [[-VLANZoneId] <Int32>] [[-Archived] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a VLAN under a specified company.
Requires a unique VLAN Id (between 4 and 4094).
Optionally associates role, status, or VLAN Zone.

## EXAMPLES

### EXAMPLE 1
```
New-HuduVLAN -Name "VLAN-200" -CompanyId 1 -VLANId 200 -Description "Internal traffic"
```

## PARAMETERS

### -Name
The name of the VLAN.

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
The company identifier to associate with this VLAN.

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

### -VLANId
The numeric VLAN Id (between 4 and 4094).

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

### -RoleListItemID
Optional Id of the role list item to associate.

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

### -StatusListItemID
Optional Id of the status list item to associate.

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

### -VLANZoneId
Optional VLAN Zone Id to associate.

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

### -Archived
Whether the VLAN should be archived upon creation ("true"/"false").
Defaults to "false".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
