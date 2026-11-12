---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduRequestOption

## SYNOPSIS
Set options for how requests to the Hudu API are made

## SYNTAX

```
Set-HuduRequestOption [[-SkipPostRetry] <Boolean>] [[-RetryDelaySeconds] <Int32>] [[-RateLimitWindowSeconds] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
A failed request (other than a rate-limited one) is retried once after -RetryDelaySeconds.
A POST that failed after Hudu had already created the record (for example a timeout) then creates it a second time; -SkipPostRetry turns the retry off for POST requests only.

A rate-limited request waits until the next rate limit window starts (plus a few seconds of jitter), then is retried.
Windows are -RateLimitWindowSeconds long, counted from midnight.

Only the options passed are changed.
The current options are returned.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduRequestOption -SkipPostRetry $true
```

### EXAMPLE 2
```
Set-HuduRequestOption -RetryDelaySeconds 2 -RateLimitWindowSeconds 60
```

## PARAMETERS

### -SkipPostRetry
Do not retry a failed POST request.
Default: $false

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryDelaySeconds
Seconds to wait before retrying a failed request.
Default: 5

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -RateLimitWindowSeconds
Length of the rate limit window, in seconds.
Default: 300

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 300
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
The options last for the session, like the API key and base URL

## RELATED LINKS
