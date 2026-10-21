---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduPasswordShares

## SYNOPSIS
Get sharing links for a password.

## SYNTAX

### List (Default)
```
Get-HuduPasswordShares -AssetPasswordId <Int64> [-Page <Int32>] [-PageSize <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ById
```
Get-HuduPasswordShares -AssetPasswordId <Int64> -Id <Int64> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves all sharing links for a password, ordered by ID, or a single sharing
link by ID.
Automatically retrieves every page unless Page is specified.
Requires an API key with access to passwords.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduPasswordShares -AssetPasswordId 42
```

Retrieves every sharing link for password 42.

### EXAMPLE 2
```
Get-HuduPasswordShares -AssetPasswordId 42 -Id 7
```

Retrieves sharing link 7 for password 42.

### EXAMPLE 3
```
Get-HuduPasswordShares -AssetPasswordId 42 -Page 2 -PageSize 25
```

Retrieves only the second page of 25 sharing links.

## PARAMETERS

### -AssetPasswordId
ID of the password the sharing links belong to.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: PasswordId, asset_password_id

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
ID of a single sharing link to retrieve.

```yaml
Type: Int64
Parameter Sets: ById
Aliases: ShareId, share_id

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
Return only this page of sharing links instead of retrieving every page.

```yaml
Type: Int32
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageSize
Number of results per page, from 1 to 1000.
Defaults to 1000.

```yaml
Type: Int32
Parameter Sets: List
Aliases: page_size

Required: False
Position: Named
Default value: 1000
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
Controls how progress records are handled.

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

### System.Management.Automation.PSCustomObject

Sharing link objects, including their public url fields.

## NOTES
API Endpoints:
GET /api/v1/asset_passwords/{asset_password_id}/shares
GET /api/v1/asset_passwords/{asset_password_id}/shares/{id}

## RELATED LINKS

[New-HuduPasswordShare](New-HuduPasswordShare.md)

[Remove-HuduPasswordShare](Remove-HuduPasswordShare.md)
