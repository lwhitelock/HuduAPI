---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduPasswordShare

## SYNOPSIS
Create a sharing link for a password.

## SYNTAX

```
New-HuduPasswordShare [-AssetPasswordId] <Int64> [-ExpireIn] <Int32> [[-Notes] <String>]
 [[-OneTimeExpire] <Boolean>] [[-IncludeUsername] <Boolean>] [[-IncludeOTP] <Boolean>]
 [[-IncludeURL] <Boolean>] [[-IncludeNotes] <Boolean>] [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a time-limited public sharing link for a password and returns the
sharing link object, including its full public url.
ExpireIn must be a
positive number of seconds; links that never expire are not permitted.
Optional fields are sent only when supplied, preserving Hudu's defaults.
Requires an API key with access to passwords and external sharing enabled
for the account.
Hudu returns HTTP 403 when external sharing is disabled.

## EXAMPLES

### EXAMPLE 1
```
New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 3600
```

Creates a sharing link that expires after one hour.

### EXAMPLE 2
```
$Share = New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 86400 -OneTimeExpire $true -IncludeUsername $true -IncludeOTP $false
$Share.url
```

Creates a one-time sharing link valid for up to one day and retrieves its URL.

## PARAMETERS

### -AssetPasswordId
ID of the password to share.

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

### -ExpireIn
Positive number of seconds until the sharing link expires.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: expire_in

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes
Notes for the sharing link.

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

### -OneTimeExpire
Whether the sharing link expires after it is viewed once.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: one_time_expire

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeUsername
Whether to include the password's username in the shared view.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_username

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeOTP
Whether to include the password's one-time password in the shared view.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_otp

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeURL
Whether to include the password's URL in the shared view.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_url

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeNotes
Whether to include the password's notes in the shared view.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_notes

Required: False
Position: 8
Default value: False
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

The created sharing link, including its public url field.

## NOTES
API Endpoint: POST /api/v1/asset_passwords/{asset_password_id}/shares

## RELATED LINKS

[Get-HuduPasswordShares](Get-HuduPasswordShares.md)

[Remove-HuduPasswordShare](Remove-HuduPasswordShare.md)
