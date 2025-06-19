

function Get-HuduRackStorageItems {
    <#
    .SYNOPSIS
    Get a list of Rack Storage Items

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
    Filter by Side ('Front' or 'Rear')

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
        [int]$RoleId,
        
        [int]$AssetId,
        
        [int]$StartUnit,
        
        [int]$EndUnit,
        
        [int]$Status,
        
        [ValidateSet('Front', 'Rear')]
        [string]$Side,
        
        [datetime]$CreatedAfter,
        
        [datetime]$CreatedBefore,
        
        [datetime]$UpdatedAfter,
        
        [datetime]$UpdatedBefore
    )

    $Resource = "/api/v1/rack_storage_items"
    $Query = [System.Collections.ArrayList]@()

    if ($RoleId) { $Query.Add("rack_storage_role_id=$RoleId") }
    if ($AssetId) { $Query.Add("asset_id=$AssetId") }
    if ($StartUnit) { $Query.Add("starting_unit=$StartUnit") }
    if ($EndUnit) { $Query.Add("end_unit=$EndUnit") }
    if ($Status) { $Query.Add("status=$Status") }
    if ($Side) { $Query.Add("side=$Side") }

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($createdRange -ne ",") {
        $Query.Add("created_at=$createdRange")
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($updatedRange -ne ",") {
        $Query.Add("updated_at=$updatedRange")
    }

    $QueryString = ($Query -join '&')

    $HuduRequest = @{
        Method   = 'GET'
        Resource = if ($QueryString) {"$Resource?$QueryString"} else {"$Resource"}
    }

    Invoke-HuduRequest @HuduRequest
}
