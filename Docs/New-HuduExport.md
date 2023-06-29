---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduExport

## SYNOPSIS
Start an export of a company

## SYNTAX

### LayoutIDs
```
New-HuduExport -Format <String> -CompanyId <Int32> [-IncludePasswords] [-IncludeWebsites]
 [-AssetLayoutIds <Int32[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LayoutNames
```
New-HuduExport -Format <String> -CompanyId <Int32> [-IncludePasswords] [-IncludeWebsites]
 [-AssetLayouts <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to create a company export

## EXAMPLES

### EXAMPLE 1
```
New-HuduExport -Format pdf -CompanyId 1 -IncludePasswords -IncludeWebsites
```

## PARAMETERS

### -Format
Format (pdf,csv,s3)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Company Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludePasswords
Include passwords in export

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeWebsites
Include websites in export

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetLayoutIds
List of asset layout ids

```yaml
Type: Int32[]
Parameter Sets: LayoutIDs
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetLayouts
Enter a list of Asset Layouts names or 'All'

```yaml
Type: String[]
Parameter Sets: LayoutNames
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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
