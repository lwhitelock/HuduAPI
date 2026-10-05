---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HapiErrorsDirectory

## SYNOPSIS
Turns on writing failed-request details to log files and the host.

## SYNTAX

```
Set-HapiErrorsDirectory [[-Path] <String>] [[-skipRetry] <Boolean>] [[-Color] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
By default a failed request is reported only on the error stream, with its details on the verbose stream (`-Verbose`).
Calling this cmdlet also writes those details to a log file in -Path and to the host.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-HapiErrorsDirectory
```

Logs failed requests under the local application data folder, in a folder named after the Hudu instance.

## PARAMETERS

### -Color
Host colour for the logged details.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White, 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Folder for the log files. Defaults to `<LocalApplicationData>/<hudu host>-errors`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -skipRetry
Do not retry a failed request (other than a rate-limited one).

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
