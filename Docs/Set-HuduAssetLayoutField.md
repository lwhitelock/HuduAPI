---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduAssetLayoutField

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
Set-HuduAssetLayoutField [-LayoutId] <Int32> [-FieldLabel] <String> [-PropertyName] <String>
 [-PropertyValue] <Object> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Updates a property on a field identified by its label and saves the layout through `Set-HuduAssetLayout`.

Setting `currency_code` on a Number field also sets `number_type = 'currency'`. Codes are trimmed and uppercased. A missing, empty, or invalid code uses the executing PowerShell session's culture, then `USD` if no regional currency is available. Currency codes cannot be set on other field types.

Setting `number_type` to `number` or `percentage` removes a stale currency code; `percent` is accepted as an alias for `percentage`. Unknown number types are rejected. Changing another property preserves an existing valid currency code.

The fallback culture comes from `Get-Culture`, not from Hudu or the company being documented. Supply an explicit code for predictable automation across regions.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -FieldLabel
{{ Fill FieldLabel Description }}

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

### -LayoutId
{{ Fill LayoutId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PropertyName
{{ Fill PropertyName Description }}

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

### -PropertyValue
{{ Fill PropertyValue Description }}

```yaml
Type: Object
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

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
