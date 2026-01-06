---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduIPAddress

## SYNOPSIS
Update a Hudu IP address.

## SYNTAX

```
Set-HuduIPAddress [-Id] <Int32> [[-Address] <String>] [[-Status] <String>] [[-FQDN] <String>]
 [[-Description] <String>] [[-Notes] <String>] [[-AssetID] <Int32>] [[-NetworkId] <Int32>]
 [[-CompanyID] <Int32>] [[-SkipDNSValidation] <Boolean>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Updates fields on an existing Hudu IPAM IP address record.
Returns the updated object on success, the existing object if nothing changed, or $null on failure.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduIPAddress -Id 1234 -Status active -Notes 'Now assigned to core switch'
```

### EXAMPLE 2
```
# Update multiple fields, preserving existing unset ones
Set-HuduIPAddress -Id 1234 -IncludeExisting -FQDN 'cam01.example.com' -Description 'Parking lot camera'
```

### EXAMPLE 3
```
# Toggle DNS validation behavior
Set-HuduIPAddress -Id 1234 -SkipDNSValidation:$false
```

## PARAMETERS

### -Id
The unique IP record ID to update (required).

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

### -Address
New IP address string (e.g.
'192.168.10.25').

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
New IP status string as used by Hudu (e.g.
'active', 'reserved', 'available').
Value is lowercased before request.

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

### -FQDN
New FQDN for this IP.

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

### -Description
New description text.

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

### -Notes
New notes text.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetID
Asset ID to (re)link this IP to.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -NetworkId
Parent Network ID to (re)associate with.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyID
Company ID to (re)associate with.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipDNSValidation
If specified, controls whether the server should skip DNS validation ('true'/'false' sent).
If $true, the server should skip DNS validation for FQDN (default: $true).
\[note- DNS validation only works if your hudu instance can resolve dns to this address, so public or same-private network\]

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: True
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

### pscustomobject (updated IP object), the existing object (if no changes), or $null on failure.
## NOTES
If no updatable parameters are provided, the cmdlet returns the existing object and exits.
'SkipDNSValidation' is serialized as a lowercased string value per API expectations.

## RELATED LINKS
