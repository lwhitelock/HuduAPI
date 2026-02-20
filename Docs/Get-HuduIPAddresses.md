---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Get-HuduIPAddresses

## SYNOPSIS
Retrieve Hudu IP address records.

## SYNTAX

```
Get-HuduIPAddresses [[-Id] <Int32>] [[-Address] <String>] [[-Status] <String>] [[-FQDN] <String>]
 [[-AssetID] <Int32>] [[-CompanyID] <Int32>] [[-CreatedAfter] <DateTime>] [[-CreatedBefore] <DateTime>]
 [[-UpdatedAfter] <DateTime>] [[-UpdatedBefore] <DateTime>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets one or more Hudu IPAM IP address objects.
 
If -Id is supplied, returns a single record (or $null if not found).
 
Without -Id, applies any provided filters and returns a collection.

## EXAMPLES

### EXAMPLE 1
```
Get-HuduIPAddresses -Id 1234
```

### EXAMPLE 2
```
Get-HuduIPAddresses -CompanyId 42 -NetworkId 7 -Status reserved
```

### EXAMPLE 3
```
# Filter by date range (created)
Get-HuduIPAddresses -CreatedAfter (Get-Date).AddDays(-7) -CreatedBefore (Get-Date)
```

## PARAMETERS

### -Id
IP address record ID to retrieve (exact match).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Address
IP address (exact string match, e.g.
'192.168.10.15').

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
IP status string as used by Hudu (e.g.
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
Fully Qualified Domain Name to filter on (exact match).

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

### -AssetID
Filter by related Asset ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyID
Filter by Company ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedAfter
Only include IPs created on/after this UTC datetime.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedBefore
Only include IPs created on/before this UTC datetime.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedAfter
Only include IPs updated on/after this UTC datetime.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdatedBefore
Only include IPs updated on/before this UTC datetime.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
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

### pscustomobject (single object when -Id is used) or an array of pscustomobject.
## NOTES
Created*/Updated* pairs are converted to the API's 'start,end' format via Convert-ToHuduDateRange.
If no filters are passed (and no -Id), all IPs are requested (server-side limits may apply).

## RELATED LINKS
