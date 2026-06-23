---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduLabelType

## SYNOPSIS
Creates a new Label Type.

## SYNTAX

```
New-HuduLabelType [-Name] <String> [-Color] <String> [[-AccessLevel] <String>]
 [-ApplicableRecordTypes] <String[]> [[-AllowedCompanyIds] <Int32[]>] [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a Label Type that can be applied to records via New-HuduLabel.
applicable_record_types must include one or more valid Hudu record types.
When
AccessLevel is specific_companies, AllowedCompanyIds must contain at least one ID.

## EXAMPLES

### EXAMPLE 1
```
New-HuduLabelType -Name "Critical" -Color "#ffff00" -ApplicableRecordTypes Asset,Website
```

### EXAMPLE 2
```
New-HuduLabelType -Name "Private" -Color "green" -AccessLevel specific_companies -ApplicableRecordTypes Asset -AllowedCompanyIds 1,2
```

### EXAMPLE 3
```
New-HuduLabelType -Name "Orange" -Color "naranja" -ApplicableRecordTypes @("asset","motdepasse","internetseite","procédure","netzwerk")
```

## PARAMETERS

### -Name
Display name for the Label Type.

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

### -Color
Hex color value for the Label Type, such as #ff0000, or a human-readable color
name supported by Set-ColorFromCanonical.
Alpha values are trimmed off.

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

### -AccessLevel
Access scope for the Label Type.
Defaults to all_companies.

```yaml
Type: String
Parameter Sets: (All)
Aliases: access_level

Required: False
Position: 3
Default value: All_companies
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicableRecordTypes
Record types this Label Type can be applied to.
(can be english, spanish, italian)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: applicable_record_types, record_types, types, applicableTypes, applicable_type, applicableType

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedCompanyIds
Company IDs allowed to use this Label Type when AccessLevel is specific_companies.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: allowed_company_ids, companyids, company_ids, companyId, company_id, companies

Required: False
Position: 5
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
API Endpoint: POST /api/v1/label_types

## RELATED LINKS
