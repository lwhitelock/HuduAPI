function Remove-HuduRackStorageItem {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
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
