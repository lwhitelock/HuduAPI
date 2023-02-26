function Get-HuduPublicPhotos {
    <#
    .SYNOPSIS
    Get a list of Public_Photos

    .DESCRIPTION
    Calls Hudu API to retrieve public photos

    .EXAMPLE
    Get-HuduPublicPhotos

    #>
    [CmdletBinding()]
    Param()

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/public_photos'
        Params   = @{}
    }
    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'public_photos'
}
