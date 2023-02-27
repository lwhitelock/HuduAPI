---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduMagicDashes

## SYNOPSIS
Get all Magic Dash Items

## SYNTAX

```
Get-HuduMagicDashes [[-CompanyId] <Int32>] [[-Title] <String>]
```

## DESCRIPTION
Call Hudu API to retrieve Magic Dashes

## EXAMPLES

### EXAMPLE 1
```
Get-HuduMagicDashes -Title 'Microsoft 365 - ...'
```

## PARAMETERS

### -CompanyId
Filter by company id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Filter by title

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
