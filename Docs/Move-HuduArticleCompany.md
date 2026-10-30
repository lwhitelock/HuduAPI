---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Move-HuduArticleCompany

## SYNOPSIS
Move a Knowledge Base Article to a different company

## SYNTAX

```
Move-HuduArticleCompany [-ArticleId] <Int32> [-CompanyId] <Int32> [[-FolderId] <Int32>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to update an article's company_id via PUT /api/v1/articles/{id}

## EXAMPLES

### EXAMPLE 1
```
Move-HuduArticleCompany -ArticleId 1 -CompanyId 20
```

### EXAMPLE 2
```
Move-HuduArticleCompany -ArticleId 1 -CompanyId $null # moves to central kb
```

### EXAMPLE 3
```
Move-HuduArticleCompany -ArticleId 1 -CompanyId 20 -FolderId 5
```

## PARAMETERS

### -ArticleId
Id of the article to move

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: article_id, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyId
Destination company id.
Use $null to move the article to the central Knowledge Base.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id, new_company_id, destination_company_id, target_company_id

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderId
Optional destination-company folder id.
When omitted, the article is moved
to the root of the destination company's Knowledge Base.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: folder_id

Required: False
Position: 3
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

## RELATED LINKS
