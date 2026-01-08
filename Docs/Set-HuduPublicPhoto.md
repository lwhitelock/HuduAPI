---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduPublicPhoto

## SYNOPSIS
Update the associated record type and ID for a specific public photo.

## SYNTAX

```
Set-HuduPublicPhoto [-id] <Object> [-RecordId] <Int32> [-RecordType] <String>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Reassociate a public photo object.
Backward Compatibility: This endpoint still accepts numeric IDs in the path parameter for existing integrations, but responses will include the new slug-based ID format.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduPublicPhoto -id 123 -RecordId 1 -RecordType 'asset'
Set-HuduPublicPhoto -id 432 -RecordId 7 -RecordType 'article'
```

## PARAMETERS

### -id
The id of the public photo to update

```yaml
Type: Object
Parameter Sets: (All)
Aliases: photo_id

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecordId
Record id to associate with the photo

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: record_id

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecordType
Record type to associate with the photo

```yaml
Type: String
Parameter Sets: (All)
Aliases: record_type

Required: True
Position: 3
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
