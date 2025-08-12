function Remove-HuduRackStorageItem {
    [CmdletBinding()]
    <#
    .SYNOPSIS
    Remove a single rack storage item from Hudu

    .DESCRIPTION
    Calls Hudu API to remove a rack storage item by Id

    .PARAMETER Id
    Id of rack storage item to delete from Hudu

    .EXAMPLE
    Remove-HuduRackStorageItem -Id 456

    Deletes the Rack Storage Item with ID 456 from Hudu.

    .NOTES
    API Endpoint: DELETE /api/v1/rack_storage_items/{id}
    #>
    param (
        [Parameter(Mandatory)]
        [int]$Id
    )

    if ($PSCmdlet.ShouldProcess("RackStorageItem $Id", "Delete")) {
        $HuduRequest = @{
            Method   = 'DELETE'
            Resource = "/api/v1/rack_storage_items/$Id"
        }

        Invoke-HuduRequest @HuduRequest
    }
}
