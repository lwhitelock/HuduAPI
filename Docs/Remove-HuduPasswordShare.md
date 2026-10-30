---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Remove-HuduPasswordShare

## SYNOPSIS
Delete a sharing link for a password.

## SYNTAX

```
Remove-HuduPasswordShare [-AssetPasswordId] <Int64> [-Id] <Int64> [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a sharing link, immediately revoking access to the shared password.
Requires an API key with access to passwords and destructive actions enabled.

## EXAMPLES

### EXAMPLE 1
```
Remove-HuduPasswordShare -AssetPasswordId 42 -Id 7
```

Revokes sharing link 7 for password 42 after confirmation.

### EXAMPLE 2
```
Get-HuduPasswordShares -AssetPasswordId 42 | Remove-HuduPasswordShare -AssetPasswordId 42 -WhatIf
```

Previews revoking every sharing link for password 42.

## PARAMETERS

### -AssetPasswordId
ID of the password the sharing link belongs to.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: PasswordId, asset_password_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
ID of the sharing link to delete.
Accepts the id property of sharing link
objects from the pipeline.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ShareId, share_id

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
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

### System.Management.Automation.PSCustomObject

Sharing link objects with an id property. Supply AssetPasswordId separately.

## OUTPUTS

## NOTES
API Endpoint: DELETE /api/v1/asset_passwords/{asset_password_id}/shares/{id}

## RELATED LINKS

[Get-HuduPasswordShares](Get-HuduPasswordShares.md)

[New-HuduPasswordShare](New-HuduPasswordShare.md)
