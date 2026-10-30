function New-HuduRackStorageItem {
    <#
    .SYNOPSIS
    Creates a new Rack Storage Item in Hudu.

    .DESCRIPTION
    Creates a rack storage item. Defaults to the front side and a single rack unit.
    When Status is omitted, items with an asset are used (1) and items without an asset are reserved (0).

    .PARAMETER RackStorageId
    The ID of the rack that will contain this item.

    .PARAMETER RackStorageRoleId
    The ID of the rack storage role.

    .PARAMETER AssetId
    The ID of the asset to associate. Omit for a reservation without a linked asset.

    .PARAMETER StartUnit
    The starting rack unit.

    .PARAMETER EndUnit
    The ending rack unit. Defaults to StartUnit for a single-unit item.

    .PARAMETER Status
    Status code: 0 for reserved, 1 for used. Defaults to 1 when AssetId is supplied and nonzero, otherwise 0.

    .PARAMETER Side
    Rack side: Front (0) or Rear (1). Accepts names or numbers and defaults to Front.

    .PARAMETER MaxWattage
    Max wattage allowed in the rack section.

    .PARAMETER PowerDraw
    Power draw for the asset in watts.

    .PARAMETER ReservedMessage
    Optional reserved message for placeholder items.

    .PARAMETER CompanyId
    Optional company ID, retained for compatibility. Only sent when explicitly supplied.

    .EXAMPLE
    New-HuduRackStorageItem -RackStorageId 10 -AssetId 123 -RackStorageRoleId 45 -StartUnit 1 -EndUnit 4

    Creates a new rack storage item (for asset id 123) designated for rack storage item role id of 45, from unit 1-4 on front of rack storage

    .EXAMPLE
    New-HuduRackStorageItem -RackStorageId 10 -RackStorageRoleId 45 -StartUnit 5 -ReservedMessage 'Future server'

    Reserves unit 5 on the front of rack 10 without requiring an asset or company ID.

    .NOTES
    API Endpoint: POST /api/v1/rack_storage_items
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]$RackStorageId,

        [Parameter(Mandatory)]
        [int]$RackStorageRoleId,

        [int]$AssetId,

        [Parameter(Mandatory)]
        [int]$StartUnit,

        [int]$EndUnit = $StartUnit,

        [ValidateSet(0, 1)]
        [int]$Status = $(if ($AssetId) { 1 } else { 0 }),

        [ValidateSet('Front', 'Rear', '0', '1')]
        [string]$Side = 'Front',
        
        [int]$MaxWattage,
        
        [int]$PowerDraw,
        
        [string]$ReservedMessage,

        [int]$CompanyId
    )
    $ItemPayload = @{
        rack_storage_id     = $RackStorageId
        rack_storage_role_id = $RackStorageRoleId
        start_unit          = $StartUnit
        end_unit            = $EndUnit
        status              = $Status
        side                = if ($Side -in @('Front', '0')) { 0 } else { 1 }
    }

    $OptionalFields = @{
        AssetId         = 'asset_id'
        CompanyId       = 'company_id'
        MaxWattage      = 'max_wattage'
        PowerDraw       = 'power_draw'
        ReservedMessage = 'reserved_message'
    }
    foreach ($ParameterName in $OptionalFields.Keys) {
        if ($PSBoundParameters.ContainsKey($ParameterName)) {
            $ItemPayload[$OptionalFields[$ParameterName]] = $PSBoundParameters[$ParameterName]
        }
    }

    $Body = @{ rack_storage_item = $ItemPayload }

    $HuduRequest = @{
        Method   = 'POST'
        Resource = '/api/v1/rack_storage_items'
        Body     = ($Body | ConvertTo-Json -Depth 10)
    }

    Invoke-HuduRequest @HuduRequest

}
