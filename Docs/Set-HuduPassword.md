---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduPassword

## SYNOPSIS
Update a Password

## SYNTAX

```
Set-HuduPassword [-Id] <Int32> [[-Name] <String>] [[-CompanyId] <Int32>] [[-PasswordableType] <String>]
 [[-PasswordableId] <Int32>] [[-InPortal] <Boolean>] [[-Password] <String>] [[-OTPSecret] <String>]
 [[-URL] <String>] [[-Username] <String>] [[-Description] <String>] [[-PasswordType] <String>]
 [[-PasswordFolderId] <Int32>] [[-Slug] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to update a password

## EXAMPLES

### EXAMPLE 1
```
Set-HuduPassword -Id 1 -CompanyId 1 -Password 'this_is_my_new_password'
```

## PARAMETERS

### -Id
Id of the requested Password

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
Password name

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

### -CompanyId
Id of requested company

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordableType
Type of asset to associate with the password

```yaml
Type: String
Parameter Sets: (All)
Aliases: passwordable_type

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordableId
Id of the asset to associate with the password

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: passwordable_id

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InPortal
Display password in portal

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: in_portal

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Password

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OTPSecret
OTP secret

```yaml
Type: String
Parameter Sets: (All)
Aliases: otp_secret

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URL
Url for the password

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

### -Username
Username

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Password description

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordType
Password type

```yaml
Type: String
Parameter Sets: (All)
Aliases: password_type

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordFolderId
Id of requested password folder

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: password_folder_id

Required: False
Position: 13
Default value: 0
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
Position: 14
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
