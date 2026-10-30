function Set-HuduRackStorageItem {
    <#
    .SYNOPSIS
    Update an existing Rack Storage Item in Hudu.

    .DESCRIPTION
    Calls the Hudu API to update a Rack Storage Item using its ID. You can modify any of the properties such as associated asset, rack units, power draw, and reserved message.
    Only explicitly supplied properties are sent. Omitted properties retain their existing values.

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
    A numeric status code for the rack item (0 for reserved, 1 for used). Omit to leave unchanged.

    .PARAMETER Side
    Rack side: Front (0) or Rear (1). Accepts names or numbers. Omit to leave unchanged.

    .PARAMETER MaxWattage
    The maximum power capacity allowed for this item.

    .PARAMETER PowerDraw
    The actual power draw of the asset, in watts.

    .PARAMETER ReservedMessage
    A text message displayed when the item is reserved. Use an empty string to clear it.

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

        [ValidateSet('Front', 'Rear', '0', '1')]
        [string]$Side,

        [int]$MaxWattage,

        [int]$PowerDraw,

        [string]$ReservedMessage
    )

    $ItemPayload = @{}
    $Fields = @{
        RackStorageRoleId = 'rack_storage_role_id'
        AssetId           = 'asset_id'
        StartUnit         = 'start_unit'
        EndUnit           = 'end_unit'
        Status            = 'status'
        MaxWattage        = 'max_wattage'
        PowerDraw         = 'power_draw'
        ReservedMessage   = 'reserved_message'
    }
    foreach ($ParameterName in $Fields.Keys) {
        if ($PSBoundParameters.ContainsKey($ParameterName)) {
            $ItemPayload[$Fields[$ParameterName]] = $PSBoundParameters[$ParameterName]
        }
    }
    if ($PSBoundParameters.ContainsKey('Side')) {
        $ItemPayload.side = if ($Side -in @('Front', '0')) { 0 } else { 1 }
    }
    if ($ItemPayload.Count -eq 0) {
        throw 'Specify at least one rack storage item property to update.'
    }

    $HuduRequest = @{
        Method      = 'PUT'
        Resource    = "/api/v1/rack_storage_items/$Id"
        Body        = (@{ rack_storage_item = $ItemPayload } | ConvertTo-Json -Depth 10)
    }
    Invoke-HuduRequest @HuduRequest
}
