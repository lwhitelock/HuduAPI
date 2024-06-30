function Move-HuduAssetsToNewLayout {
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
