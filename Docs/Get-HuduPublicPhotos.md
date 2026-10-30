---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduPublicPhotos

## SYNOPSIS
Get a list of public photos or a single public photo, optionally downloading files.

## SYNTAX

```
Get-HuduPublicPhotos [[-Id] <String>] [[-Numeric_Id] <Int32>] [-Download] [[-OutDir] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls Hudu API to retrieve public photos.

If -Download is specified with -Numeric_Id or -Id (single) or without either identifier (list), downloads public photo files using /public_photos/{numeric_id}?download=true.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduPublicPhotos
```

### EXAMPLE 2
```
Get-HuduPublicPhotos -Id 4
```

### EXAMPLE 3
```
Get-HuduPublicPhotos -Slug 'public-photo-slug'
```

### EXAMPLE 4
```
Get-HuduPublicPhotos -Id 4 -Download
```

### EXAMPLE 5
```
Get-HuduPublicPhotos -Download -OutDir "$env:TEMP\public-photos"
```

## PARAMETERS

### -Id
Slug-based ID of the public photo to retrieve or download.
Numeric values are coerced to Numeric_Id unless they are 12 digits.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Slug

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Numeric_Id
Numeric ID of the public photo to retrieve or download.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: NumericId

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Download
If specified, downloads public photo file(s) to OutDir.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutDir
Directory to download public photos into.
Default current directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: .
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
