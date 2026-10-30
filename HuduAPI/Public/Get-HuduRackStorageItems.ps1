

function Get-HuduRackStorageItems {
    <#
    .SYNOPSIS
    Provide a rack storage item id to Get a single rack storage item, otherwise Get a list of Rack Storage Items

    .DESCRIPTION
    Calls Hudu API to retrieve rack storage items with filters like asset ID, role, side, etc.

    .PARAMETER Id
    ID of a single rack storage item to retrieve.

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
    Filter by Front (0) or Rear (1). Accepts names or numbers. Omit to return either side.

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
        
        [ValidateSet('Front', 'Rear', '0', '1')]
        [string]$Side,
        
        [datetime]$CreatedAfter,
        
        [datetime]$CreatedBefore,
        
        [datetime]$UpdatedAfter,
        
        [datetime]$UpdatedBefore
    )

    $BaseResource = "/api/v1/rack_storage_items"

    $Params = @{}
    $Filters = @{
        RoleId    = 'rack_storage_role_id'
        AssetId   = 'asset_id'
        StartUnit = 'start_unit'
        EndUnit   = 'end_unit'
        Status    = 'status'
    }
    foreach ($ParameterName in $Filters.Keys) {
        if ($PSBoundParameters.ContainsKey($ParameterName)) {
            $Params[$Filters[$ParameterName]] = $PSBoundParameters[$ParameterName]
        }
    }
    if ($PSBoundParameters.ContainsKey('Side')) {
        $Params.side = if ($Side -in @('Front', '0')) { 'Front' } else { 'Rear' }
    }

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($null -ne $createdRange -and $createdRange -ne ',') {
        $Params.created_at = $createdRange
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($null -ne $updatedRange -and $updatedRange -ne ',') {
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
            Params   = $Params
        }
    }

    Invoke-HuduRequest @HuduRequest
}
