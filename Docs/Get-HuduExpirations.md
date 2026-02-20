---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduExpirations

## SYNOPSIS
Get expirations for account

## SYNTAX

```
Get-HuduExpirations [[-CompanyId] <Int32>] [[-ExpirationType] <String>] [[-ResourceId] <Int32>]
 [[-ResourceType] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve expirations

## EXAMPLES

### EXAMPLE 1
```
Get-HuduExpirations -ExpirationType domain
```

## PARAMETERS

### -CompanyId
Filter expirations by company_id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpirationType
Filter expirations by expiration type (undeclared, domain, ssl_certificate, warranty, asset_field, article_expiration)

```yaml
Type: String
Parameter Sets: (All)
Aliases: expiration_type

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
Filter logs by resource id.
Must be coupled with resource_type

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: resource_id

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceType
Filter logs by resource type (Asset, AssetPassword, Company, Article, etc.).
Must be coupled with resource_id

```yaml
Type: String
Parameter Sets: (All)
Aliases: resource_type

Required: False
Position: 4
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
