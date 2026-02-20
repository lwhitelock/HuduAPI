---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduFlags

## SYNOPSIS
Gets Flags from Hudu.

## SYNTAX

### List (Default)
```
Get-HuduFlags [-FlagTypeId <Int32>] [-flagable_type <String>] [-flagable_id <Int32>] [-Description <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ById
```
Get-HuduFlags [-Id <Int32>] [-Description <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves a single Flag by ID, or lists Flags with optional filtering by flag type,
target object type/id, and description.
Results are paginated when listing.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduFlags
# List all flags (paginated)
```

### EXAMPLE 2
```
Get-HuduFlags -FlagTypeId 5
# List all flags using flag type 5
```

### EXAMPLE 3
```
Get-HuduFlags -flagable_type Company -flagable_id 123
# List all flags attached to company 123
```

### EXAMPLE 4
```
Get-HuduFlags -Id 77
# Get a single flag by ID
```

## PARAMETERS

### -Id
Return a single Flag by ID.

```yaml
Type: Int32
Parameter Sets: ById
Aliases: FlagId, flag_id

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FlagTypeId
Filter flags by Flag Type ID.

```yaml
Type: Int32
Parameter Sets: List
Aliases: Flag_Type_ID, FlagType_ID, Flag_TypeId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -flagable_type
Filter by the target object type the flag is attached to (e.g., Company, Asset).
This value is normalized to Hudu's canonical flagable_type.

```yaml
Type: String
Parameter Sets: List
Aliases: flagabletype, flaggable_type, flaggabletype, Flag_type, FlagType

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -flagable_id
Filter by the target object ID the flag is attached to.

```yaml
Type: Int32
Parameter Sets: List
Aliases: FlaggableId, flaggable_id, flagableid

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Filter by description text (exact match behavior depends on API; treat as an exact filter unless documented otherwise).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
API Endpoints:
- GET /api/v1/flags
- GET /api/v1/flags/{id}

## RELATED LINKS
