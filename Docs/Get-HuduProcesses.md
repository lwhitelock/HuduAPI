---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduProcesses

## SYNOPSIS
Get a list of Procedures (Processes)

## SYNTAX

### Single
```
Get-HuduProcesses [-Id <Int32>] [<CommonParameters>]
```

### List
```
Get-HuduProcesses [-CompanyId <Int32>] [-Name <String>] [-Slug <String>] [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve list of procedures

## EXAMPLES

### EXAMPLE 1
```
Get-HuduProcesses -Name 'Procedure 1'
```

## PARAMETERS

### -Id
Id of the Procedure

```yaml
Type: Int32
Parameter Sets: Single
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Filter by company id

```yaml
Type: Int32
Parameter Sets: List
Aliases: company_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Fitler by name of article

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Filter by url slug

```yaml
Type: String
Parameter Sets: List
Aliases:

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
