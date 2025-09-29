function Remove-HuduRackStorage {
    <#
    .SYNOPSIS
    Remove a single Rack Storage from Hudu.

    .DESCRIPTION
    Calls the Hudu API to delete a Rack Storage by its ID. This operation is permanent and cannot be undone.

    .PARAMETER Id
    The ID of the Rack Storage to delete.

    .EXAMPLE
    Remove-HuduRackStorage -Id 123

    Deletes the Rack Storage with ID 123.

    .NOTES
    API Endpoint: DELETE /api/v1/rack_storages/{id}
    Requires confirmation before deletion unless -Confirm:$false is specified.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Id
    )

    if ($PSCmdlet.ShouldProcess("Rack Storage $Id", "Delete")) {
        $Request = @{
            Method   = 'DELETE'
            Resource = "/api/v1/rack_storages/$Id"
        }

        Invoke-HuduRequest @Request
    }
}