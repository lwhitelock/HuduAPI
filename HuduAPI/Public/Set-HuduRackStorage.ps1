function Set-HuduRackStorage {
    <#
    .SYNOPSIS
    Update an existing Rack Storage in Hudu.

    .DESCRIPTION
    Calls the Hudu API to update a Rack Storage by ID. You can update any subset of properties including name, dimensions, company, or location.
    Only explicitly supplied properties are sent. Omitted properties retain their existing values.

    .PARAMETER Id
    ID of the Rack Storage to update.

    .PARAMETER Name
    Updated name for the Rack Storage.

    .PARAMETER LocationId
    Updated location ID for the Rack Storage.

    .PARAMETER CompanyId
    Updated company ID associated with the Rack Storage.

    .PARAMETER Description
    Optional updated description for the Rack Storage. Use an empty string to clear it.

    .PARAMETER MaxWattage
    Maximum power rating (watts) for the updated Rack Storage.

    .PARAMETER StartingUnit
    The new starting rack unit number.

    .PARAMETER Height
    The new height in rack units (U).

    .PARAMETER Width
    The new width of the rack.

    .EXAMPLE
    Set-HuduRackStorage -Id 123 -Name "Rack A-02" -Height 45

    Updates Rack Storage 123 to be renamed "Rack A-02" with 45U height.

    .NOTES
    API Endpoint: PUT /api/v1/rack_storages/{id}
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Id,

        [string]$Name,

        [int]$CompanyId,

        [int]$Height,

        [int]$Width,

        [int]$LocationId,

        [string]$Description,

        [int]$MaxWattage,

        [int]$StartingUnit

    )

    $Body = @{}
    $Fields = @{
        Name         = 'name'
        LocationId   = 'location_id'
        CompanyId    = 'company_id'
        Description  = 'description'
        MaxWattage   = 'max_wattage'
        StartingUnit = 'starting_unit'
        Height       = 'height'
        Width        = 'width'
    }
    foreach ($ParameterName in $Fields.Keys) {
        if ($PSBoundParameters.ContainsKey($ParameterName)) {
            $Body[$Fields[$ParameterName]] = $PSBoundParameters[$ParameterName]
        }
    }
    if ($Body.Count -eq 0) {
        throw 'Specify at least one rack storage property to update.'
    }

    $Request = @{
        Method   = 'PUT'
        Resource = "/api/v1/rack_storages/$Id"
        Body     = ($Body | ConvertTo-Json -Depth 10)
    }

    Invoke-HuduRequest @Request
}
