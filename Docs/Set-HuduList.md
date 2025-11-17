---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduList

## SYNOPSIS
Update an existing Hudu List

## SYNTAX

```
Set-HuduList [-Id] <Int32> [-Name] <String> [-ListItems] <Hashtable[]> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to update a List.
You may modify item names, add new items, or mark items for deletion.

## EXAMPLES

### EXAMPLE 1
```
Update-HuduList -Id 456 -Name "Updated List" -ListItems @(
    @{ id = 1; name = "Updated Value" },
    @{ name = "New Value" },
    @{ id = 2; _destroy = $true }
)
```

## PARAMETERS

### -Id
ID of the list to update

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
New name for the list

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ListItems
Array of item hashtables.
Use \`id\` and \`name\` to update, or \`_destroy = $true\` to remove.

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
