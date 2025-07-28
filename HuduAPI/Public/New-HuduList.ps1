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

    $listItems = $Items | ForEach-Object { @{ name = $_ } }

    $payload = @{
        list = @{
            name = $Name
            list_items_attributes = $listItems
        }
    } | ConvertTo-Json -Depth 10

    try {
        $response = Invoke-HuduRequest -Method POST -Resource "/api/v1/lists" -Body $payload
        return $response
    } catch {
        Write-Warning "Failed to create list '$Name'"
        return $null
    }
}
