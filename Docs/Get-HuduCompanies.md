---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduCompanies

## SYNOPSIS
Get a list of companies

## SYNTAX

```
Get-HuduCompanies [[-Name] <String>] [[-PhoneNumber] <String>] [[-Website] <String>] [[-City] <String>]
 [[-State] <String>] [[-IdInIntegration] <Int32>] [[-Id] <Int32>] [[-Search] <String>] [[-Slug] <String>]
 [[-UpdatedAfter] <DateTime>] [[-UpdatedBefore] <DateTime>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Call Hudu API to retrieve company list

## EXAMPLES

### EXAMPLE 1
```
Get-HuduCompanies -Search 'Vendor'
Get-HuduCompanies -Updatedafter $(get-date).Addyears(-1)
```

## PARAMETERS

### -Name
Filter companies by name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PhoneNumber
filter companies by phone number

```yaml
Type: String
Parameter Sets: (All)
Aliases: phone_number

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Website
Filter companies by website

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

### -City
Filter companies by city

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
Filter companies by state

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdInIntegration
Filter companies by id/identifier in PSA/RMM/outside integration

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: id_in_integration

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Filter companies by id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Search
Filter by search query

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

### -Slug
Filter by url slug

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

### -UpdatedAfter
Get Companies Updated After X datetime

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedBefore
Get Companies Updated Before Y datetime

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
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
