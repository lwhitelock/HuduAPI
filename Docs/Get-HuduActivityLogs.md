---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduActivityLogs

## SYNOPSIS
Get activity logs for account

## SYNTAX

```
Get-HuduActivityLogs [[-UserId] <Int32>] [[-UserEmail] <String>] [[-ResourceId] <Int32>]
 [[-ResourceType] <String>] [[-ActionMessage] <String>] [[-StartDate] <DateTime>] [[-EndDate] <DateTime>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve activity logs with filters

## EXAMPLES

### EXAMPLE 1
```
Get-HuduActivityLogs -StartDate 2023-02-01
```

## PARAMETERS

### -UserId
Filter logs by user_id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: user_id

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserEmail
Filter logs by email address

```yaml
Type: String
Parameter Sets: (All)
Aliases: user_email

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

### -ActionMessage
Filter logs by action

```yaml
Type: String
Parameter Sets: (All)
Aliases: action_message

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
Filter logs by start date.
Converts string to ISO 8601 format

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: start_date

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
Filter logs by end date, should be coupled with start date to limit results

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: end_date

Required: False
Position: 7
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
