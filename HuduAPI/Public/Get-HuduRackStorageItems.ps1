

function Get-HuduRackStorageItems {
    <#
    .SYNOPSIS
    Provide a rack storage item id to Get a single rack storage item, otherwise Get a list of Rack Storage Items

    .DESCRIPTION
    Calls Hudu API to retrieve rack storage items with filters like asset ID, role, side, etc.

    .PARAMETER RoleId
    Filter by Rack Storage Role ID

    .PARAMETER AssetId
    Filter by Asset ID

    .PARAMETER StartUnit
    Filter by Start Unit

    .PARAMETER EndUnit
    Filter by End Unit

    .PARAMETER Status
    Filter by Status

    .PARAMETER Side
    Filter by Side (0='Front' or 1='Rear')

    .PARAMETER CreatedAfter
    Start datetime for created_at range

    .PARAMETER CreatedBefore
    End datetime for created_at range

    .PARAMETER UpdatedAfter
    Start datetime for updated_at range

    .PARAMETER UpdatedBefore
    End datetime for updated_at range
    
    .EXAMPLE
    Get-HuduRackStorageItems -RoleId 12 -Side 'Front'

    Returns all front-facing rack items associated with role ID 12.

    .NOTES
    API Endpoint: GET /api/v1/rack_storage_items
    #>
    [CmdletBinding()]
    param (
        [int]$Id,

        [int]$RoleId,
        
        [int]$AssetId,
        
        [int]$StartUnit,
        
        [int]$EndUnit,
        
        [int]$Status,
        
        [ValidateSet(0, 1)]
        [int]$Side,
        
        [datetime]$CreatedAfter,
        
        [datetime]$CreatedBefore,
        
        [datetime]$UpdatedAfter,
        
        [datetime]$UpdatedBefore
    )

    $BaseResource = "/api/v1/rack_storage_items"

    $Params = @{}
    if ($RoleId) { $Params["rack_storage_role_id"] = $RoleId }
    if ($AssetId) { $Params["asset_id"] = $AssetId }
    if ($StartUnit) { $Params["starting_unit"] = $StartUnit }
    if ($EndUnit) { $Params["end_unit"] = $EndUnit }
    if ($Status) { $Params["status"] = $Status }
    if ($Side) { $Params["side"] = $Side }

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($createdRange -ne ',' -and -$null -ne $createdRange) {
        $Params.created_at = $createdRange
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
        $Params.updated_at = $updatedRange
    }
    
    $HuduRequest = if ($Id) {
        @{
            Method   = 'GET'
            Resource = "$BaseResource/$Id"
        }
    } else {
        @{
            Method   = 'GET'
            Resource = "$BaseResource"
            Params   = if ($Params.Count -gt 0) { $Params } else { $null }
        }
    }

    Invoke-HuduRequest @HuduRequest
}
