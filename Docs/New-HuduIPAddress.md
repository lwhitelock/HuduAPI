---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# New-HuduIPAddress

## SYNOPSIS
Create a new Hudu IP address.

## SYNTAX

```
New-HuduIPAddress [-Address] <String> [-NetworkId] <Int32> [-CompanyID] <Int32> [[-Status] <String>]
 [[-FQDN] <String>] [[-Description] <String>] [[-Notes] <String>] [[-AssetID] <Int32>]
 [[-SkipDNSValidation] <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a Hudu IPAM IP address record within a specific Company and Network.
Returns the created IP address object on success, or $null on failure.

## EXAMPLES

### EXAMPLE 1
```
New-HuduIPAddress -Address '10.20.30.15' -CompanyId 42 -NetworkId 7 -Status reserved
```

### EXAMPLE 2
```
New-HuduIPAddress -Address '172.16.0.10' -CompanyId 42 -NetworkId 7 -FQDN 'printer01.example.com' -Description 'Front office printer'
```

## PARAMETERS

### -Address
The IP address to create (required).
Example: '192.168.10.15'.

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

### -NetworkId
Parent Network ID to associate with (required).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyID
Company ID to associate with (required).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
IP status string as used by Hudu (e.g.
'active', 'reserved', 'available').

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

### -FQDN
Optional FQDN for this IP.

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

### -Description
Free-form description for the IP record.

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

### -Notes
Free-form notes for the IP record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetID
Related Asset ID to link this IP to.

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

### -SkipDNSValidation
If $true, the server should skip DNS validation for FQDN (default: $true).
\[note- DNS validation only works if your hudu instance can resolve dns to this address, so public or same-private network\]

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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

### pscustomobject (the created IP address object) or $null on failure.
## NOTES
Status is passed through as provided; the module lowercases certain fields as needed by the API.
SkipDNSValidation is sent as a lowercased string value ('true'/'false') per API expectations.

## RELATED LINKS
