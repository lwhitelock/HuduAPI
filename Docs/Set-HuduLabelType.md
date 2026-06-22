---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduLabelType

## SYNOPSIS
Updates a Label Type.

## SYNTAX

```
Set-HuduLabelType [-Id] <Int32> [[-Name] <String>] [[-Color] <String>] [[-AccessLevel] <String>]
 [[-ApplicableRecordTypes] <String[]>] [[-AllowedCompanyIds] <Int32[]>] [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Label Type by ID.
When setting AccessLevel to specific_companies,
AllowedCompanyIds must contain at least one company ID, either from the existing
Label Type or from the provided parameter.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduLabelType -Id 1 -Name "AnotherLabel" -Color "scharlachrot"
```

### EXAMPLE 2
```
Set-HuduLabelType -Id 1 -Name "Critical" -Color "#ff0000"
```

### EXAMPLE 3
```
Set-HuduLabelType -Id 1 -Name "Colorful" -Color "naranja" -ApplicableRecordTypes @("asset","motdepasse","internetseite","procédure","netzwerk")
```

## PARAMETERS

### -Id
ID of the Label Type to update.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: LabelTypeId, label_type_id, labeltype_id, label_typeid, type_id, typeid

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Updated name.

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

### -Color
Updated hex color value for the Label Type, such as #1c12a3, or a
human-readable color name supported by Set-ColorFromCanonical.
Alpha values are
trimmed off.

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

### -AccessLevel
Updated access scope.

```yaml
Type: String
Parameter Sets: (All)
Aliases: access_level

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicableRecordTypes
Updated list of record types this Label Type can be applied to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: applicable_record_types, record_types, types, applicableTypes, applicable_type, applicableType

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedCompanyIds
Updated list of company IDs allowed to use this Label Type when AccessLevel is specific_companies.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: allowed_company_ids, companyids, company_ids, companyId, company_id, companies

Required: False
Position: 6
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
API Endpoint: PUT /api/v1/label_types/{id}

## RELATED LINKS
