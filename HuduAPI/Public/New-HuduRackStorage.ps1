function New-HuduRackStorage {
    <#
    .SYNOPSIS
    Creates a new Rack Storage in Hudu.

    .DESCRIPTION
    Sends a request to the Hudu API to create a new Rack Storage, including properties such as name, dimensions, location, and associated company.

    .PARAMETER Name
    The name of the new rack (e.g., "Rack A-01"). This is required.

    .PARAMETER LocationId
    The ID of the location where this rack is physically installed. Optional.

    .PARAMETER CompanyId
    The ID of the company associated with the rack. Optional, but useful for filtering.

    .PARAMETER Description
    A brief description or note for the rack (e.g., "Primary server rack"). Optional.

    .PARAMETER MaxWattage
    The maximum wattage supported by the rack. Optional.

    .PARAMETER StartingUnit
    The starting rack unit number (e.g., 1 if it's a full rack). Optional.

    .PARAMETER Height
    Total number of rack units (U) in height (e.g., 42 for a standard rack). Optional.

    .PARAMETER Width
    The width of the rack in millimeters or another defined unit (depending on Hudu's expected units). Optional.

    .EXAMPLE
    New-HuduRackStorage -Name "Rack A-01" -LocationId 12 -CompanyId 34 -Height 42 -StartingUnit 1

    Creates a new rack called "Rack A-01" at location ID 12, linked to company ID 34, with 42U height starting from unit 1.

    .EXAMPLE
    Get-HuduRackStorage -Id 101

    Returns the Rack Storage with ID 101.

    .NOTES
    API Endpoint: GET /api/v1/rack_storages/{id}
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [int]$CompanyId,

        [Parameter(Mandatory)]
        [int]$Height,

        [Parameter(Mandatory)]
        [int]$Width,

        [int]$LocationId,

        [string]$Description,

        [int]$MaxWattage,

        [int]$StartingUnit
    )

    $Body = @{
        name          = $Name
        location_id   = $LocationId
        company_id    = $CompanyId
        description   = $Description
        max_wattage   = $MaxWattage
        starting_unit = $StartingUnit
        height        = $Height
        width         = $Width
    } | ConvertTo-Json -Depth 10

    $HuduRequest = @{
        Method   = 'POST'
        Resource = '/api/v1/rack_storages'
        Body     = $Body
    }

    Invoke-HuduRequest @HuduRequest
}
