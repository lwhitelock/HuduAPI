---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduGroups

## SYNOPSIS
Retrieve Hudu groups.

## SYNTAX

```
Get-HuduGroups [[-Id] <Int32>] [[-Name] <String>] [[-Search] <String>] [[-Default] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to return groups.
 
You can fetch a single group by Id, or filter/search across all groups.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduGroups
Retrieves all groups.
```

### EXAMPLE 2
```
Get-HuduGroups -Id 123
Retrieves the group with ID 123.
```

### EXAMPLE 3
```
Get-HuduGroups -Search "Technicians"
Returns all groups matching the word "Technicians".
```

## PARAMETERS

### -Id
The numeric ID of the group to retrieve.

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

### -Name
Name of the group (for filtering).

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

### -Search
Search string to filter groups by.

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

### -Default
Boolean flag to return only default groups.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
