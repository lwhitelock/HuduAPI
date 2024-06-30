function Move-HuduAssetsToNewLayout {
<#
    .SYNOPSIS
    Helper function that uses the Set-HuduAsset function to move an asset between asset layouts. This will leave behind orphan data in the database.
    Review the article https://portal.risingtidegroup.net/kb?id=29 for more details.

    .DESCRIPTION
    Calls the Hudu API to update an asset by switching its asset_layout_id property to a different asset layout. 
    This function migrates the asset to the specified new layout while maintaining its fields. Note that this 
    operation may leave behind orphaned data in the Hudu database, so use it with caution.

    .PARAMETER AssetsToMove
    An array of assets to be moved to a new asset layout. Each asset must contain both 'id' and 'fields' properties.

    .PARAMETER NewAssetLayoutID
    The ID of the new asset layout to which the assets will be moved.

    .EXAMPLE
    $AssetLayout = Get-HuduAssetLayouts -Name "Servers"
    $AssetsToUpdate = Get-HuduAssets -AssetLayoutId 9
    Move-HuduAssetsToNewLayout -AssetsToMove $AssetsToUpdate -NewAssetLayoutID $AssetLayout.id

    This example retrieves the asset layout with the name "Servers" and the assets with the layout ID 9, then moves those assets to the new layout.

    .NOTES
    Ensure that the new asset layout ID is valid and that the assets to be moved contain the required properties.
    Using this function may result in orphaned data in your Hudu database. Review the provided article for more details.
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($BadAssets = ($_ | where {(-not $_.id)})) {
                    $BadAssets
                    throw "Assets must be an object with an ID"
                }
            return $true
        })]
        [array]
        $AssetsToMove,

        [Parameter(Mandatory = $true)]
        [int]
        $NewAssetLayoutID
    )

    Write-Warning "Performing this function will leave behind orphaned data in your Hudu database. Please review https://portal.risingtidegroup.net/kb?id=29"
    Read-Host "Press Enter to continue or (CTRL+C) to cancel..."

    $assets = foreach ($AssetToMove in $AssetsToMove) {
        if (-not ($AssetToMove.PSObject.Properties.Match('id')) -or -not ($AssetToMove.PSObject.Properties.Match('fields'))) {
            Write-Error "Asset does not contain both 'id' and 'fields' properties. Skipping this asset."
            continue
        }

        if (-not $AssetToMove.fields) {
            Write-Warning "Asset ID: $($AssetToMove.id) has no fields. Proceeding with moving the asset."
        }

        $assetId = $AssetToMove.id

        if ($PSCmdlet.ShouldProcess("Asset ID: $assetId", "Move to new layout with ID $NewAssetLayoutID")) {
            try {
                Write-Verbose "Processing Asset ID: $assetId"

                $fields = New-Object -TypeName psobject
                foreach ($field in $AssetToMove.fields) {
                    $fieldName = $field.label.replace(' ', '_').tolower()
                    $fields | Add-Member -MemberType NoteProperty -Name $fieldName -Value $field.value -Force
                }

                (Set-HuduAsset -Id $assetId -AssetLayoutId $NewAssetLayoutID -Fields $fields).asset

                Write-Verbose "Successfully moved Asset ID: $assetId"
            }
            catch {
                Write-Error "Failed to move Asset ID: $assetId. Error: $_"
            }
            finally {
                Remove-Variable -Name fields -ErrorAction SilentlyContinue
            }
        }
    }
    return $assets
}
