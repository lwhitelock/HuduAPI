function Remove-HuduPasswordFolder {
    <#
    .SYNOPSIS
    Delete a PasswordFolder by ID

    .DESCRIPTION
    Uses Hudu API to remove passwordfolder

    .PARAMETER Id
    Id of the passwordfolder

    .EXAMPLE
    Remove-HuduPasswordFolder -Id 1

    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id
    )
    process {
        Invoke-HuduRequest -Method delete -Resource "/api/v1/password_folders/$Id"
    }
}
