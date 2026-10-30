---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Move-HuduAssetCompany

## SYNOPSIS
Move an Asset to a different company

## SYNTAX

```
Move-HuduAssetCompany [-AssetId] <Int32> [-CompanyId] <Int32> [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to update an asset's company_id via PUT /api/v1/companies/{company_id}/assets/{id}

The company in the URL identifies the asset, so it must be the company that
currently owns it.
That id is looked up from the asset itself; CompanyId is
the destination and is sent in the body.

## EXAMPLES

### EXAMPLE 1
```
Move-HuduAssetCompany -AssetId 1 -CompanyId 20
```

### EXAMPLE 2
```
Move-HuduAssetCompany -AssetId 1 -CompanyId 44
```

## PARAMETERS

### -AssetId
Id of the asset to move

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: asset_id, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Destination company id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id, new_company_id, destination_company_id, target_company_id

Required: True
Position: 2
Default value: 0
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

## RELATED LINKS
