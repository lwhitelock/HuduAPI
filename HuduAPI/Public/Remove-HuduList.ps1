function Remove-HuduList {
    <#
    .SYNOPSIS
    Delete a Hudu List

    .DESCRIPTION
    Calls the Hudu API to delete a List by ID.

    .PARAMETER Id
    ID of the list to delete

    .EXAMPLE
    Remove-HuduList -Id 789 -WhatIf

    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id
    )

    try {
        Invoke-HuduRequest -Method DELETE -Resource "/api/v1/lists/$Id"
        Write-Host "Successfully deleted list ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete list ID $Id"
    }
    
}