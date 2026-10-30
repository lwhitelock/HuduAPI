function Get-HuduRackStorages {
    <#
    .SYNOPSIS
    Get a list of Rack Storages or provide ID to get a single rack storage

    .DESCRIPTION
    Retrieves rack storages by ID or filters such as company, location, dimensions, and date ranges.
    
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
    $Filters = @{
        CompanyId  = 'company_id'
        LocationId = 'location_id'
        Height     = 'height'
        MinWidth   = 'min_width'
        MaxWidth   = 'max_width'
    }
    foreach ($ParameterName in $Filters.Keys) {
        if ($PSBoundParameters.ContainsKey($ParameterName)) {
            $Params[$Filters[$ParameterName]] = $PSBoundParameters[$ParameterName]
        }
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
