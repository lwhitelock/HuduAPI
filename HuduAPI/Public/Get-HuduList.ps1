function Get-HuduLists {
    <#
    .SYNOPSIS
    Get a list of Hudu Lists or List by ID

    .DESCRIPTION
    Calls the Hudu API to retrieve all Lists. Optionally filter by exact name.

    .PARAMETER Name
    Filter by exact list name (optional)

    .PARAMETER Id
    ID of the list to retrieve

    .EXAMPLE
    Get-HuduListById -Id 123

    .EXAMPLE
    Get-HuduLists

    .EXAMPLE
    Get-HuduLists -Name "Device Status"

#>    
    [CmdletBinding()]
    param(
        [string]$Name,
        [int]$Id
    )


    if ($null -ne $Id) {
        $response = Invoke-HuduRequest -Method GET -Resource "/api/v1/lists/$Id"
    } else {
        $response = Invoke-HuduRequest -Method GET -Resource "/api/v1/lists"
    }

    if (-not $response) {
        return $null
    }

    $lists = $response

    if ($Name) {
        $filtered = $lists | Where-Object { $_.name -eq $Name }
        if ($filtered) {
            return $filtered
        } else {
            Write-Warning "No list found with name '$Name'"
            return $null
        }
    }
    return $lists
}