function Get-HuduRackStorageItem {
    [CmdletBinding()]
    <#
    .SYNOPSIS
    Get a single rack storage item

    .DESCRIPTION
    Calls Hudu API to get a rack storage item by Id

    .PARAMETER Id
    Id of rack storage item to get from Hudu

    .EXAMPLE
    Get-HuduRackStorageItem -Id 234

    Returns the Rack Storage Item with ID 234.

    .NOTES
    API Endpoint: GET /api/v1/rack_storage_items/{id}
    #>

    param (
        [Parameter(Mandatory)]
        [int]$Id
    )

    $HuduRequest = @{
        Method   = 'GET'
        Resource = "/api/v1/rack_storage_items/$Id"
    }

    Invoke-HuduRequest @HuduRequest
}
