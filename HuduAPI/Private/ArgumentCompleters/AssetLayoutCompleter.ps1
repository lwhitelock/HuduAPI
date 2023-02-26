$AssetLayoutCompleter = {
    param (
        $CommandName,
        $ParamName,
        $AssetLayout,
        $CommandAst,
        $fakeBoundParameters
    )
    if (!$script:AssetLayouts) {
        Get-HuduAssetLayouts | Out-Null
    }

    $AssetLayout = $AssetLayout -replace "'", ''
    ($script:AssetLayouts).name | Where-Object { $_ -match "$AssetLayout" } | ForEach-Object { "'$_'" }
}

Register-ArgumentCompleter -CommandName Get-HuduAssets -ParameterName AssetLayout -ScriptBlock $AssetLayoutCompleter
