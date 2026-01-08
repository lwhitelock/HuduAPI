function Set-HuduPublicPhoto {
    <#
    .SYNOPSIS
    Update the associated record type and ID for a specific public photo.

    .DESCRIPTION
    Reassociate a public photo object. Backward Compatibility: This endpoint still accepts numeric IDs in the path parameter for existing integrations, but responses will include the new slug-based ID format.

    .PARAMETER Id
    The id of the public photo to update

    .PARAMETER RecordId
    Record id to associate with the photo

    .PARAMETER RecordType
    Record type to associate with the photo

    .EXAMPLE
    Set-HuduPublicPhoto -id 123 -RecordId 1 -RecordType 'asset'
    Set-HuduPublicPhoto -id 432 -RecordId 7 -RecordType 'article'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [Alias('photo_id')]
        [object]$id,

        [Parameter(Mandatory)]
        [Alias('record_id')]
        [int]$RecordId,

        [Parameter(Mandatory)]
        [Alias('record_type')]
        [string]$RecordType
    )
    $photo = get-hudupublicphotos | Where-Object { $_.numeric_id -eq $id -or $_.id -eq $id } | Select-Object -first 1
    $photo = $photo.public_photo ?? $photo
    if (-not $photo) {throw "File not found!"}
    if (-not $RecordId) {throw "RecordId is required!"}
    if (-not $RecordType) {throw "RecordType is required!"}
    
    if ($photo.record_id -eq $RecordId -and $photo.record_type -eq $RecordType) {
        Write-Verbose "Photo already associated with Record ID $RecordId and Record Type $RecordType. No changes made."
        return
    }
    if ($PSCmdlet.ShouldProcess($File.FullName)) {
        Invoke-HuduRequest -Method PUT -Resource "/api/v1/public_photos/$($photo.numeric_id)" `
            -Form @{
                'record_id'   = $RecordId
                'record_type' = $RecordType
            }
    }
}
