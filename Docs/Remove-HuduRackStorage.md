---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Remove-HuduRackStorage

## SYNOPSIS
Remove a single Rack Storage from Hudu.

## SYNTAX

```
Remove-HuduRackStorage [-Id] <Int32> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to delete a Rack Storage by its ID.
This operation is permanent and cannot be undone.

## EXAMPLES

### EXAMPLE 1
```
Remove-HuduRackStorage -Id 123
```

Deletes the Rack Storage with ID 123.

## PARAMETERS

### -Id
The ID of the Rack Storage to delete.

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
API Endpoint: DELETE /api/v1/rack_storages/{id}
Requires confirmation before deletion unless -Confirm:$false is specified.

## RELATED LINKS
