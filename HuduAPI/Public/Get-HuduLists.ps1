function Get-HuduLists {
    <#
    .SYNOPSIS
    Get a list of Hudu Lists or a List by ID

    .DESCRIPTION
    Calls the Hudu API to retrieve all Lists. Optionally filter by exact name or retrieve a single list by ID.

    .PARAMETER Id
    ID of the list to retrieve

    .PARAMETER Name
    Filter by exact list name (optional)

    .EXAMPLE
    Get-HuduLists -Id 123

    .EXAMPLE
    Get-HuduLists

    .EXAMPLE
    Get-HuduLists -Name "Device Status"
    #>
    [CmdletBinding()]
    param(
        [int]$Id,
        [string]$Name
    )

    if ($Id) {
        try {
            return Invoke-HuduRequest -Method GET -Resource "/api/v1/lists/$Id"
        } catch {
            Write-Warning "Failed to retrieve list with ID $Id"
            return $null
        }
    }

    $lists = Invoke-HuduRequest -Method GET -Resource "/api/v1/lists"

    if ($Name) {
        $match = $lists | Where-Object { $_.name -eq $Name }
        if ($match) {
            return $match
        }
        Write-Warning "No list found with name '$Name'"
        return $null
    }

    return $lists
}
