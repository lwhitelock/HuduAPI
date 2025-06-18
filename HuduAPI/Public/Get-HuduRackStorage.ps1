function Get-HuduRackStorage {
    [CmdletBinding()]
    <#
    .SYNOPSIS
    Get a single rack storage

    .DESCRIPTION
    Calls Hudu API to get a rack storage by Id

    .PARAMETER Id
    Id of rack storage to get from Hudu
    #>     
    param (
        [Parameter(Mandatory)]
        [int]$Id
    )

    $HuduRequest = @{
        Method   = 'GET'
        Resource = "/api/v1/rack_storages/$Id"
    }

    Invoke-HuduRequest @HuduRequest
}
