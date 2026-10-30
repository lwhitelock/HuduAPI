function Get-HuduPublicPhotos {
    <#
    .SYNOPSIS
    Get a list of public photos or a single public photo, optionally downloading files.

    .DESCRIPTION
    Calls Hudu API to retrieve public photos.

    If -Download is specified with -Numeric_Id or -Id (single) or without either identifier (list), downloads public photo files using /public_photos/{numeric_id}?download=true.

    .PARAMETER Id
    Slug-based ID of the public photo to retrieve or download. Numeric values are coerced to Numeric_Id unless they are 12 digits.

    .PARAMETER Numeric_Id
    Numeric ID of the public photo to retrieve or download.

    .PARAMETER Download
    If specified, downloads public photo file(s) to OutDir.

    .PARAMETER OutDir
    Directory to download public photos into. Default current directory.

    .EXAMPLE
    Get-HuduPublicPhotos

    .EXAMPLE
    Get-HuduPublicPhotos -Id 4

    .EXAMPLE
    Get-HuduPublicPhotos -Slug 'public-photo-slug'

    .EXAMPLE
    Get-HuduPublicPhotos -Id 4 -Download

    .EXAMPLE
    Get-HuduPublicPhotos -Download -OutDir "$env:TEMP\public-photos"

    #>
    [CmdletBinding()]
    param(
        [Alias('Slug')]
        [string]$Id,
        [Alias('NumericId')]
        [Nullable[int]]$Numeric_Id,
        [switch]$Download,
        [string]$OutDir = '.'
    )

    $hasId = $PSBoundParameters.ContainsKey('Id') -and -not [string]::IsNullOrWhiteSpace($Id)
    $hasNumericId = $PSBoundParameters.ContainsKey('Numeric_Id') -and $null -ne $Numeric_Id

    if (-not $hasId -and -not $hasNumericId) {
        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/public_photos'
            Params   = @{}
        }

        $PublicPhotos = Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'public_photos'
        if (-not $Download) {
            return $PublicPhotos
        }
    }

    $numericId = $Numeric_Id
    $idText = "$Id".Trim()
    $parsedNumericId = 0
    if (
        -not $hasNumericId -and
        -not [string]::IsNullOrWhiteSpace($idText) -and
        $idText -notmatch '^\d{12}$' -and
        [int]::TryParse($idText, [ref]$parsedNumericId)
    ) {
        $numericId = $parsedNumericId
    }

    if ($null -ne $numericId) {
        $result = Invoke-HuduRequest -Method Get -Resource "/api/v1/public_photos/$numericId"
        $PublicPhotos = @($result.public_photo ?? $result)
    } elseif ($hasId) {
        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/public_photos'
            Params   = @{}
        }
        $PublicPhotos = Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'public_photos'

        $PublicPhotos = @($PublicPhotos | Where-Object { $_.id -eq $Id })
    }

    if ($Download) {
        $OutDir = if ([string]::IsNullOrWhiteSpace($OutDir)) { (Get-Location).Path } else { $OutDir }
        $OutDir = (New-Item -ItemType Directory -Path $OutDir -Force).FullName

        $Headers = @{ 'x-api-key' = (New-Object PSCredential 'user', $(Get-HuduApiKey)).GetNetworkCredential().Password }
        foreach ($p in @($PublicPhotos)) {
            $publicPhotoId = $p.numeric_id ?? $p.id
            if (-not $publicPhotoId) { continue }

            $safeName = ($p.file_name -replace '[<>:"/\\|?*\x00-\x1F]', '_')
            if ([string]::IsNullOrWhiteSpace($safeName)) { $safeName = "public-photo-$publicPhotoId" }

            $destinationPath = Join-Path -Path $OutDir -ChildPath $safeName
            $fileUrl = "$((Get-HuduBaseURL))/api/v1/public_photos/$($publicPhotoId)?download=true"

            try {
                Invoke-WebRequest -Uri $fileUrl -OutFile $destinationPath -Headers $Headers -MaximumRedirection 5 -ErrorAction Stop | Out-Null
                Write-Verbose "Downloaded '$publicPhotoId' to '$destinationPath'"
                if (Test-Path -LiteralPath $destinationPath) {
                    $p | Add-Member -MemberType NoteProperty -Name localPath -Value $destinationPath -Force
                }
            } catch {
                Write-Warning "Failed to download public photo '$publicPhotoId' from '$fileUrl': $($_.Exception.Message)"
            }
        }
    }

    $singlePublicPhoto = ($null -ne $numericId) -or $hasId
    $publicPhotosOut = $(($singlePublicPhoto ? ($PublicPhotos[0]) : $PublicPhotos))

    return $publicPhotosOut
}
