function New-HuduRackStorageItem {
    <#
    .SYNOPSIS
    Creates a new Rack Storage Item in Hudu.

    .DESCRIPTION
    Calls Hudu API to create a new rack storage item

    .PARAMETER RackStorageRoleId
    The ID of the rack storage role.

    .PARAMETER AssetId
    The ID of the asset to associate.

    .PARAMETER StartUnit
    The starting rack unit.

    .PARAMETER EndUnit
    The ending rack unit.

    .PARAMETER Status
    Integer status code for the rack storage item.

    .PARAMETER Side
    Rack side: 'Front' or 'Rear'.

    .PARAMETER MaxWattage
    Max wattage allowed in the rack section.

    .PARAMETER PowerDraw
    Power draw for the asset in watts.

    .PARAMETER ReservedMessage
    Optional reserved message for placeholder items.

    .PARAMETER CompanyId
    Company ID to associate with the rack item.

    .EXAMPLE
    New-HuduRackStorageItem -AssetId 123 -RackStorageRoleId 45 -StartUnit 1 -EndUnit 4 -Status 1 -Side "Front"

    Creates a new rack storage item (for asset id 123) designated for rack storage item role id of 45, from unit 1-4 on front of rack storage
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]$RackStorageRoleId,

        [Parameter(Mandatory)]
        [int]$AssetId,

        [Parameter(Mandatory)]
        [int]$StartUnit,

        [Parameter(Mandatory)]
        [int]$EndUnit,

        [int]$Status,

        [ValidateSet("Front", "Rear")]
        [string]$Side,
        
        [int]$MaxWattage,
        
        [int]$PowerDraw,
        
        [string]$ReservedMessage,
        
        [int]$CompanyId
    )

    $Body = @{
        rack_storage_role_id = $RackStorageRoleId
        asset_id              = $AssetId
        start_unit            = $StartUnit
        end_unit              = $EndUnit
    }

    if ($Status)           { $Body.status = $Status }
    if ($Side)             { $Body.side = $Side }
    if ($MaxWattage)       { $Body.max_wattage = $MaxWattage }
    if ($PowerDraw)        { $Body.power_draw = $PowerDraw }
    if ($ReservedMessage)  { $Body.reserved_message = $ReservedMessage }
    if ($CompanyId)        { $Body.company_id = $CompanyId }

    $HuduRequest = @{
        Method   = 'POST'
        Resource = '/api/v1/rack_storage_items'
        Body     = ($Body | ConvertTo-Json -Depth 10)
    }

    Invoke-HuduRequest @HuduRequest
}
