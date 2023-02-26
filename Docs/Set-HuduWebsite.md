---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduWebsite

## SYNOPSIS
Update a Website

## SYNTAX

```
Set-HuduWebsite [-Id] <Int32> [-Name] <String> [[-Notes] <String>] [[-Paused] <String>] [-CompanyId] <Int32>
 [[-DisableDNS] <String>] [[-DisableSSL] <String>] [[-DisableWhois] <String>] [[-Slug] <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to update a website

## EXAMPLES

### EXAMPLE 1
```
Set-HuduWebsite -Id 1 -Paused $true
```

## PARAMETERS

### -Id
Id of requested website

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
Website name (e.g.
https://example.com)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes
Website Notes

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

### -Paused
When true, website monitoring is paused.

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

### -CompanyId
Used to associate website with company

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: True
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableDNS
When true, dns monitoring is paused.

```yaml
Type: String
Parameter Sets: (All)
Aliases: disable_dns

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableSSL
When true, ssl cert monitoring is paused.

```yaml
Type: String
Parameter Sets: (All)
Aliases: disable_ssl

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableWhois
When true, whois monitoring is paused.

```yaml
Type: String
Parameter Sets: (All)
Aliases: disable_whois

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Slug
Url identifier

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
