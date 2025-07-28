function New-HuduList {
    <#
    .SYNOPSIS
    Create a new Hudu List

    .DESCRIPTION
    Calls the Hudu API to create a new List with the specified name and items.

    .PARAMETER Name
    Name of the new list

    .PARAMETER Items
    An array of item names to include in the list

    .EXAMPLE
    New-HuduList -Name "Device Status" -Items @("Online", "Offline", "Decommissioned")

    #>    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string[]]$Items
    )

    $payload = @{
        list = @{
            name = $Name
            list_items_attributes = @()
        }
    }

    foreach ($item in $Items) {
        $payload.list.list_items_attributes += @{ name = $item }
    }

    $jsonBody = $payload | ConvertTo-Json -Depth 100

    try {
        $response = Invoke-HuduRequest -Method POST -Resource "/api/v1/lists" -Body $jsonBody
        if ($response) {
            return $($response | ConvertFrom-Json -depth 6)
        }
    } catch {
        return $null
    }
}
