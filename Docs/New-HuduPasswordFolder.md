---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduPasswordFolder

## SYNOPSIS
Create a new password folder.

## SYNTAX

```
New-HuduPasswordFolder [-Name] <String> [-CompanyId] <Int32> [[-Description] <String>] [[-Security] <String>]
 [[-AllowedGroups] <Array>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to create a password folder for a given company.
 
Supports configuring name, description, security settings, and allowed groups.

## EXAMPLES

### EXAMPLE 1
```
New-HuduPasswordFolder -Name "Infrastructure" -CompanyId 2
Creates a folder named "Infrastructure" for company ID 2.
```

### EXAMPLE 2
```
New-HuduPasswordFolder -Name "Finance" -CompanyId 4 -Security specific -AllowedGroups @(10,12)
Creates a folder for company 4 restricted to groups 10 and 12.
```

## PARAMETERS

### -Name
Name of the new folder (required).

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
The company ID that owns the folder (required).

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

### -Description
Description of the folder.

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
