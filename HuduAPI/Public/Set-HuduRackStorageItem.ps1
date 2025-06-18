function Set-HuduRackStorageItem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]$Id,

        [int]$RackStorageRoleId,
        [int]$AssetId,
        [int]$StartUnit,
        [int]$EndUnit,
        [int]$Status,
        [ValidateSet('Front', 'Rear')][string]$Side,
        [int]$MaxWattage,
        [int]$PowerDraw,
        [string]$ReservedMessage
    )

    $Body = @{}

    if ($RackStorageRoleId) { $Body.rack_storage_role_id = $RackStorageRoleId }
    if ($AssetId)           { $Body.asset_id = $AssetId }
    if ($StartUnit)         { $Body.start_unit = $StartUnit }
    if ($EndUnit)           { $Body.end_unit = $EndUnit }
    if ($Status)            { $Body.status = $Status }
    if ($Side)              { $Body.side = $Side }
    if ($MaxWattage)        { $Body.max_wattage = $MaxWattage }
    if ($PowerDraw)         { $Body.power_draw = $PowerDraw }
    if ($ReservedMessage)   { $Body.reserved_message = $ReservedMessage }

    $HuduRequest = @{
        Method   = 'PUT'
        Resource = "/api/v1/rack_storage_items/$Id"
        Body     = $Body
    }

    Invoke-HuduRequest @HuduRequest
}
