---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Set-HuduMagicDash

## SYNOPSIS
Create or Update a Magic Dash Item

## SYNTAX

```
Set-HuduMagicDash [-Title] <String> [-CompanyName] <String> [-Message] <String> [[-Icon] <String>]
 [[-ImageURL] <String>] [[-ContentLink] <String>] [[-Content] <String>] [[-Shade] <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Magic Dash takes just simple key-pairs.
Whether you want to add a new Magic Dash Item, or update one, you can use the same endpoint, so it is really easy!
It uses the title, and company_name to match.

## EXAMPLES

### EXAMPLE 1
```
Set-HuduMagicDash -Title 'Test Dash' -CompanyName 'Test Company' -Message 'This will be displayed first'
```

## PARAMETERS

### -Title
This is the title.
If there is an existing Magic Dash Item with matching title and company_name, then it will match into that item.

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

### -CompanyName
This is the attribute we use to match to an existing company.
If there is an existing Magic Dash Item with matching title and company_name, then it will match into that item.

```yaml
Type: String
Parameter Sets: (All)
Aliases: company_name

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
This will be the first content that will be displayed on the Magic Dash Item.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
Either fill this in, or image_url.
Use a (FontAwesome icon for the header of a Magic Dash Item.
Must be in the format of fas fa-circle

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

### -ImageURL
Either fill this in, or icon.
Used in the header of a Magic Dash Item.

```yaml
Type: String
Parameter Sets: (All)
Aliases: image_url

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentLink
Either fill this in, or content, or leave both blank.
Used to have a link to an external website.

```yaml
Type: String
Parameter Sets: (All)
Aliases: content_link

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
Either fill this in, or content_link, or leave both blank.
Fill in with HTML (tables, images, videos, etc.) to display more content in your Magic Dash Item.

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

### -Shade
Use a different color for your Magic Dash Item for different contextual states.
Options are to leave it blank, success, or danger

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
