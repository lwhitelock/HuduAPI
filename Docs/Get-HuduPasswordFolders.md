---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduPasswordFolders

## SYNOPSIS
Retrieve password folders.

## SYNTAX

```
Get-HuduPasswordFolders [[-Id] <Int32>] [[-Name] <String>] [[-Search] <String>] [[-CompanyId] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to return password folders.
 
You can fetch a single folder by Id, or filter by name/company.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduPasswordFolders
Retrieves all password folders.
```

### EXAMPLE 2
```
Get-HuduPasswordFolders -Id 12
Retrieves the folder with ID 12.
```

### EXAMPLE 3
```
Get-HuduPasswordFolders -CompanyId 5
Retrieves folders belonging to company with ID 5.
```

## PARAMETERS

### -Id
The numeric ID of the folder to retrieve.

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
Filter by folder name.

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
{{ Fill Search Description }}

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
Filter by company ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 4
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
