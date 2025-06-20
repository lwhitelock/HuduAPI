function Set-HuduRackStorage {
    <#
    .SYNOPSIS
    Update an existing Rack Storage in Hudu.

    .DESCRIPTION
    Calls the Hudu API to update a Rack Storage by ID. You can update any subset of properties including name, dimensions, company, or location.

    .PARAMETER Id
    ID of the Rack Storage to update.

    .PARAMETER Name
    Updated name for the Rack Storage.

    .PARAMETER LocationId
    Updated location ID for the Rack Storage.

    .PARAMETER CompanyId
    Updated company ID associated with the Rack Storage.

    .PARAMETER Description
    Optional updated description for the Rack Storage.

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
    if ($Name)          { $Body.name = $Name }
    if ($LocationId)    { $Body.location_id = $LocationId }
    if ($CompanyId)     { $Body.company_id = $CompanyId }
    if ($Description)   { $Body.description = $Description }
    if ($MaxWattage)    { $Body.max_wattage = $MaxWattage }
    if ($StartingUnit)  { $Body.starting_unit = $StartingUnit }
    if ($Height)        { $Body.height = $Height }
    if ($Width)         { $Body.width = $Width }

    $Request = @{
        Method   = 'PUT'
        Resource = "/api/v1/rack_storages/$Id"
        Body     = ($Body | ConvertTo-Json -Depth 10)
    }

    Invoke-HuduRequest @Request
}
