function Get-HuduRackStorages {
    <#
    .SYNOPSIS
    Get a list of Rack Storages or provide ID to get a single rack storage

    .DESCRIPTION
    Calls Hudu API to retrieve rack storage items with filters like asset ID, role, side, etc.
    
    .PARAMETER Id
    ID of the Rack Storage to get

    .PARAMETER CompanyId
    Filter Rack Storages by Company Id

    .PARAMETER LocationId
    Filter Rack Storages by Location Id

    .PARAMETER Height
    Filter Rack Storages by available storage height

    .PARAMETER MaxWidth
    Filter Rack Storages by maximum available storage width

    .PARAMETER MinWidth
    Filter Rack Storages by minimum available storage width

    .PARAMETER CreatedAfter
    Start datetime for created_at range

    .PARAMETER CreatedBefore
    End datetime for created_at range

    .PARAMETER UpdatedAfter
    Start datetime for updated_at range

    .PARAMETER UpdatedBefore
    End datetime for updated_at range

    .EXAMPLE
    Get-HuduRackStorages -CompanyId 42 -MinWidth 600 -MaxWidth 800

    Returns racks for company ID 42 with widths between 600 and 800.

    .NOTES
    API Endpoint: GET /api/v1/rack_storages
    #>    
    #>    
    [CmdletBinding()]
    param (
        [int]$Id,

        [int]$CompanyId,

        [int]$LocationId,

        [int]$Height,

        [int]$MinWidth,

        [int]$MaxWidth,

        [datetime]$CreatedAfter,

        [datetime]$CreatedBefore,

        [datetime]$UpdatedAfter,

        [datetime]$UpdatedBefore
    )

    $BaseResource = "/api/v1/rack_storages"

    $Params = @{}
    if ($CompanyId)   { $Params.company_id = $CompanyId }
    if ($LocationId)  { $Params.location_id = $LocationId }
    if ($Height)      { $Params.height = $Height }
    if ($MinWidth)    { $Params.min_width = $MinWidth }
    if ($MaxWidth)    { $Params.max_width = $MaxWidth }

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
            Params   = $Params
        }
    }

    Invoke-HuduRequest @HuduRequest
}
