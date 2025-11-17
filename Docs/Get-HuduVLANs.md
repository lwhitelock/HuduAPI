---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduVLANs

## SYNOPSIS
Retrieve VLAN records from Hudu.

## SYNTAX

```
Get-HuduVLANs [[-Id] <Int32>] [[-VLANId] <Int32>] [[-VLANZoneID] <Int32>] [[-CompanyId] <Int32>]
 [[-Slug] <String>] [[-Name] <String>] [[-Archived] <String>] [[-CreatedAfter] <DateTime>]
 [[-CreatedBefore] <DateTime>] [[-UpdatedAfter] <DateTime>] [[-UpdatedBefore] <DateTime>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Queries the Hudu API for VLANs.
Supports filtering by Id, VLAN Id, VLAN Zone association, company, slug, 
name, archival status, or creation/update timestamps.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduVLANs -CompanyId 5 -Archived "false"
```

## PARAMETERS

### -Id
Specific VLAN Id.

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

### -VLANId
Filter by VLAN Id (must be between 4 and 4094).

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

### -VLANZoneID
Filter by associated VLAN Zone Id.

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

### -CompanyId
Filter by company identifier.

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

### -Slug
Filter by slug value.

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

### -Name
Filter by VLAN name.

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

### -Archived
Filter by archival status: "true" or "false".

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

### -CreatedAfter
Return VLANs created after this date/time.

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
Return VLANs created before this date/time.

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
Return VLANs updated after this date/time.

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
Return VLANs updated before this date/time.

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

## RELATED LINKS
