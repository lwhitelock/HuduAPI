---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduPasswordFolder

## SYNOPSIS
Update an existing password folder.

## SYNTAX

```
Set-HuduPasswordFolder [-Id] <Int32> [[-Name] <String>] [[-Description] <String>] [[-Security] <String>]
 [[-AllowedGroups] <Array>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to update details of an existing password folder.
 
You can change the name, description, security mode, or allowed groups.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduPasswordFolder -Id 5 -Name "Updated Folder"
Renames folder ID 5 to "Updated Folder".
```

### EXAMPLE 2
```
Set-HuduPasswordFolder -Id 7 -Security specific -AllowedGroups @(3,4)
Restricts folder ID 7 access to groups 3 and 4.
```

## PARAMETERS

### -Id
The numeric ID of the folder to update (required).

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
New folder name.
If omitted, the existing name is retained.

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

### -Description
New description.
If omitted, the existing description is retained.

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

### -Security
Security mode.
Accepts "all_users" or "specific".

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

### -AllowedGroups
Array of group IDs that should have access (if Security is "specific").

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
