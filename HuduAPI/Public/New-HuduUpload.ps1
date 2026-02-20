function New-HuduUpload {
    <#
    .SYNOPSIS
    Create a Upload

    .DESCRIPTION
    Uses Hudu API to upload a file for use in an asset. RecordType can be of 'asset','website','procedure','assetpassword','comapny','article'.

    .PARAMETER FilePath
    Path to the file

    .PARAMETER RecordId
    Record id to associate with the Upload

    .PARAMETER RecordType
    Record type to associate with the Upload

    .EXAMPLE
    New-HuduUpload -FilePath 'c:\path\to\file.png' -RecordId 1 -RecordType 'asset'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$FilePath,

        [Parameter(Mandatory)]
        [Alias('record_id','recordid')]
        [int]$uploadable_id,

        [Parameter(Mandatory)]
        [Alias('record_type','recordtype')]
        [ValidateSet("Article", "AssetPassword", "Asset", "IpAddress", "Network", "RackStorage", "VlanZone", "Vlan", "Website",IgnoreCase = $true)]
        [string]$uploadable_type
    )

    $File = Get-Item -LiteralPath $FilePath
    if (-not $File) { throw "File not found!" }
    
    $form = @{
        file = $File
        "upload[uploadable_id]" = $uploadable_id
        "upload[uploadable_type]" = $uploadable_type
    }

    if ($PSCmdlet.ShouldProcess($File.FullName)) {
        Invoke-HuduRequest -Method POST -Resource '/api/v1/uploads' -Form $form
    }
}
