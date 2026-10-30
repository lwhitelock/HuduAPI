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
    The ID of the company associated with the rack. Required.

    .PARAMETER Description
    A brief description or note for the rack (e.g., "Primary server rack"). Optional.

    .PARAMETER MaxWattage
    The maximum wattage supported by the rack. Optional.

    .PARAMETER StartingUnit
    The starting rack unit number. Defaults to 1. Use 0 for zero-based rack numbering.

    .PARAMETER Height
    Total number of rack units (U) in height (e.g., 42 for a standard rack). Required.

    .PARAMETER Width
    The rack width in the units expected by your Hudu instance. Required.

    .EXAMPLE
    New-HuduRackStorage -Name "Rack A-01" -LocationId 12 -CompanyId 34 -Height 42 -Width 19

    Creates a new rack called "Rack A-01" at location ID 12, linked to company ID 34, with 42U height starting from unit 1.

    .NOTES
    API Endpoint: POST /api/v1/rack_storages
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

        [int]$StartingUnit = 1
    )

    $Body = @{
        name          = $Name
        company_id    = $CompanyId
        starting_unit = $StartingUnit
        height        = $Height
        width         = $Width
    }
    $OptionalFields = @{
        LocationId  = 'location_id'
        Description = 'description'
        MaxWattage  = 'max_wattage'
    }
    foreach ($ParameterName in $OptionalFields.Keys) {
        if ($PSBoundParameters.ContainsKey($ParameterName)) {
            $Body[$OptionalFields[$ParameterName]] = $PSBoundParameters[$ParameterName]
        }
    }

    $HuduRequest = @{
        Method   = 'POST'
        Resource = '/api/v1/rack_storages'
        Body     = ($Body | ConvertTo-Json -Depth 10)
    }

    Invoke-HuduRequest @HuduRequest
}
