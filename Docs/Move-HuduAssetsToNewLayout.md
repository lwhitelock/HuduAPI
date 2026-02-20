---
external help file: HuduAPI-help.xml
Module Name: HuduAPI
online version:
schema: 2.0.0
---

# Move-HuduAssetsToNewLayout

## SYNOPSIS
Helper function that uses the Set-HuduAsset function to move an asset between asset layouts.
This will leave behind orphan data in the database.
Review the article https://portal.risingtidegroup.net/kb?id=29 for more details.

## SYNTAX

```
Move-HuduAssetsToNewLayout [-AssetsToMove] <Array> [-NewAssetLayoutID] <Int32>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Calls the Hudu API to update an asset by switching its asset_layout_id property to a different asset layout. 
This function migrates the asset to the specified new layout while maintaining its fields.
Note that this 
operation may leave behind orphaned data in the Hudu database, so use it with caution.

## EXAMPLES

### EXAMPLE 1
```
$AssetLayout = Get-HuduAssetLayouts -Name "Servers"
$AssetsToUpdate = Get-HuduAssets -AssetLayoutId 9
Move-HuduAssetsToNewLayout -AssetsToMove $AssetsToUpdate -NewAssetLayoutID $AssetLayout.id
```

This example retrieves the asset layout with the name "Servers" and the assets with the layout ID 9, then moves those assets to the new layout.

## PARAMETERS

### -AssetsToMove
An array of assets to be moved to a new asset layout.
Each asset must contain both 'id' and 'fields' properties.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewAssetLayoutID
The ID of the new asset layout to which the assets will be moved.

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
Ensure that the new asset layout ID is valid and that the assets to be moved contain the required properties.
Using this function may result in orphaned data in your Hudu database.
Review the provided article for more details.

## RELATED LINKS
