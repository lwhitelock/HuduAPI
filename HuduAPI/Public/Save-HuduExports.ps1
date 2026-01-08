
function Save-HuduExports {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter()]
        [long]$Id,
        [Parameter()]
        [string]$OutDir = '.'
    )

    $OutDir = [string]::IsNullOrWhiteSpace($OutDir) ? (Get-Location).Path : $OutDir
    $OutDir = (New-Item -ItemType Directory -Path $OutDir -Force).FullName
    $exports = $(if ($null -ne $Id) {@(Get-HuduExports -id $id)} else {@(Get-HuduExports)})

    if (-not $exports -or $exports.Count -eq 0) {Write-Warning "No exports available."; return;}
    $HuduAPIKey = Get-HuduApiKey
    $Headers = @{'x-api-key' = (New-Object PSCredential 'user', $HuduAPIKey).GetNetworkCredential().Password;}

    $files = @(); $fileIDX = 0;
    foreach ($export in $exports) {
        $fileIDX++; $downloadedFile = $null;
        $fileName = $export.file_name ?? "export-$($export.id)$(if ($export.is_pdf) { '.pdf' } else { '.csv' })"

        if (-not $export.download_url -or [string]::isnullorempty($export.download_url)) {
            Write-Warning "Export id $($export.id) has no download_url yet (status=$($export.status)). Skipping."
            write-host "$($($export | convertto-json -depth 99).ToSTring())"
            continue
        }

        $outPath = Join-Path $OutDir $fileName

        if ($PSCmdlet.ShouldProcess($outPath, "Download export id $exId")) {
            Invoke-WebRequest -Uri $export.download_url -headers $headers -OutFile $outPath -MaximumRedirection 10 | Out-Null
        }
        $downloadedFile = $(Get-Item -LiteralPath $outPath)
        Write-Host "downloaded $fileName to $($downloadedFile) ($fileIDX of $($exports.count))"
        $files+=$($downloadedFile)
    }
    return $files
}
