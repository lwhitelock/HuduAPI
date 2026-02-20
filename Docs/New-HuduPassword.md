---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduPassword

## SYNOPSIS
Create a Password

## SYNTAX

```
New-HuduPassword [-Name] <String> [-CompanyId] <Int32> [[-PasswordableType] <String>]
 [[-PasswordableId] <Int32>] [[-InPortal] <Boolean>] [-Password] <String> [[-OTPSecret] <String>]
 [[-URL] <String>] [[-Username] <String>] [[-Description] <String>] [[-PasswordType] <String>]
 [[-PasswordFolderId] <Int32>] [[-Slug] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Hudu API to create a new password

## EXAMPLES

### EXAMPLE 1
```
New-HuduPassword -Name 'Some website password' -Username 'user@domain.com' -Password '12345'
```

## PARAMETERS

### -Name
Name of the password

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

### -CompanyId
Company id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: company_id

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordableType
Asset type for the password

```yaml
Type: String
Parameter Sets: (All)
Aliases: passwordable_type

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordableId
Asset id for the password

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: passwordable_id

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InPortal
Boolean for in portal

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: in_portal

Required: False
Position: 5
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

Required: True
Position: 6
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
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URL
Password URL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Position: 9
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
Position: 10
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
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordFolderId
Password folder id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: password_folder_id

Required: False
Position: 12
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
Position: 13
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
