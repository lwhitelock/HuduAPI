function Update-HuduList {
    <#
    .SYNOPSIS
    Update an existing Hudu List

    .DESCRIPTION
    Calls the Hudu API to update a List. You may modify item names, add new items, or mark items for deletion.

    .PARAMETER Id
    ID of the list to update

    .PARAMETER Name
    New name for the list

    .PARAMETER ListItems
    Array of item hashtables. Use `id` and `name` to update, or `_destroy = $true` to remove.

    .EXAMPLE
    Update-HuduList -Id 456 -Name "Updated List" -ListItems @(
        @{ id = 1; name = "Updated Value" },
        @{ name = "New Value" },
        @{ id = 2; _destroy = $true }
    )

    #>    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id,

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [hashtable[]]$ListItems
    )

    $payload = @{
        list = @{
            name = $Name
            list_items_attributes = $ListItems
        }
    }

    $jsonBody = $payload | ConvertTo-Json -Depth 100

    try {
        $response = Invoke-HuduRequest -Method PUT -Resource "/api/v1/lists/$Id" -Body $jsonBody
        if ($response) {
            return $response | ConvertFrom-Json -Depth 6
        }
    } catch {
        Write-Warning "Failed to update list with ID $Id"
        return $null
    }
}
