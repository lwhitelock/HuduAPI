function Set-HuduRackStorageItem {
    <#
    .SYNOPSIS
    Update an existing Rack Storage Item in Hudu.

    .DESCRIPTION
    Calls the Hudu API to update a Rack Storage Item using its ID. You can modify any of the properties such as associated asset, rack units, power draw, and reserved message.

    .PARAMETER Id
    The ID of the Rack Storage Item to update.

    .PARAMETER RackStorageRoleId
    The ID of the Rack Storage Role to associate with this item.

    .PARAMETER AssetId
    The ID of the Asset to associate with this rack slot.

    .PARAMETER StartUnit
    The rack unit where this asset begins (e.g., 1 for top of rack).

    .PARAMETER EndUnit
    The rack unit where this asset ends.

    .PARAMETER Status
    A status code indicating the usage or reservation state of the rack item.

    .PARAMETER Side
    The side of the rack the item is on ('Front' or 'Rear').

    .PARAMETER MaxWattage
    The maximum power capacity allowed for this item.

    .PARAMETER PowerDraw
    The actual power draw of the asset, in watts.

    .PARAMETER ReservedMessage
    A text message displayed when the item is reserved.

    .EXAMPLE
    Set-HuduRackStorageItem -Id 456 -StartUnit 10 -EndUnit 15 -Side "Rear" -PowerDraw 120

    Updates the Rack Storage Item 456 to span units 10–15 on the rear side and sets its power draw to 120W.

    .NOTES
    API Endpoint: PUT /api/v1/rack_storage_items/{id}
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]$Id,

        [int]$RackStorageRoleId,

        [int]$AssetId,

        [int]$StartUnit,

        [int]$EndUnit,

        [int]$Status,

        [ValidateSet(1, 0)][int]$Side,

        [int]$MaxWattage,

        [int]$PowerDraw,

        [string]$ReservedMessage
    )

    $Body = @{}

    if ($RackStorageRoleId) { $Body.rack_storage_role_id = $RackStorageRoleId }
    if ($AssetId)           { $Body.asset_id = $AssetId }
    if ($EndUnit)           { $Body.end_unit = $EndUnit }
    if ($MaxWattage)        { $Body.max_wattage = $MaxWattage }
    if ($PowerDraw)         { $Body.power_draw = $PowerDraw }
    if ($ReservedMessage)   { $Body.reserved_message = $ReservedMessage }

    $existing = Get-HuduRackStorageItems -Id $Id

    if (-not $PSBoundParameters.ContainsKey('StartUnit')) {
        $StartUnit = $existing.start_unit
    }
    if (-not $PSBoundParameters.ContainsKey('Side')) {
        $Side = if ($existing.side.ToLower() -eq "front") {0} else {1}
    }
    if (-not $PSBoundParameters.ContainsKey('Status')) {
        $Status = if ($existing.status.toLower() -eq "reserved") {0} else {1}
    }

    $HuduRequest = @{
        Method      = 'PUT'
        Resource    = "/api/v1/rack_storage_items/$Id"
        Body        = ($Body | ConvertTo-Json -Depth 10)
    }
    Invoke-HuduRequest @HuduRequest
}
