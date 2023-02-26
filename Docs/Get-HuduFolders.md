---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduFolders

## SYNOPSIS
Get a list of Folders

## SYNTAX

```
Get-HuduFolders [[-Id] <Int32>] [[-Name] <String>] [[-CompanyId] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve folders

## EXAMPLES

### EXAMPLE 1
```
Get-HuduFolders
```

## PARAMETERS

### -Id
Id of the folder

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Filter by name

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

### -CompanyId
Filter by company_id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 3
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
