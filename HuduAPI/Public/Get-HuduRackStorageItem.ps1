function Get-HuduRackStorageItem {
    [CmdletBinding()]
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
