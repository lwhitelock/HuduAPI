function New-HuduPublicPhoto {
    <#
    .SYNOPSIS
    Create a Public Photo

    .DESCRIPTION
    Uses Hudu API to upload an image for use in an asset or article

    .PARAMETER FilePath
    Path to the image

    .PARAMETER RecordId
    Record id to associate with the photo

    .PARAMETER RecordType
    Record type to associate with the photo

    .EXAMPLE
    New-HuduPublicPhoto -FilePath 'c:\path\to\image.png' -RecordId 1 -RecordType 'asset'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$FilePath,

        [Alias('record_id')]
        [int]$RecordId,

        [Alias('record_type')]
        [string]$RecordType
    )

    $File = Get-Item -LiteralPath $FilePath
    if (-not $File) {throw "File not found!"}
    $form = @{
        photo = $File
    }

    if ($RecordId) { $form['record_id'] = $RecordId }
    if ($RecordType) { $form['record_type'] = $RecordType }

    if ($PSCmdlet.ShouldProcess($File.FullName)) {
        Invoke-HuduRequest -Method POST -Resource '/api/v1/public_photos' -Form $form
    }
}
