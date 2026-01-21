function Set-HuduPasswordFolder {
    <#
    .SYNOPSIS
    Update an existing password folder.

    .DESCRIPTION
    Calls the Hudu API to update details of an existing password folder.  
    You can change the name, description, security mode, or allowed groups.

    .PARAMETER Id
    The numeric ID of the folder to update (required).

    .PARAMETER Name
    New folder name. If omitted, the existing name is retained.

    .PARAMETER Description
    New description. If omitted, the existing description is retained.

    .PARAMETER Security
    Security mode. Accepts "all_users" or "specific".

    .PARAMETER AllowedGroups
    Array of group IDs that should have access (if Security is "specific").

    .EXAMPLE
    Set-HuduPasswordFolder -Id 5 -Name "Updated Folder"
    Renames folder ID 5 to "Updated Folder".

    .EXAMPLE
    Set-HuduPasswordFolder -Id 7 -Security specific -AllowedGroups @(3,4)
    Restricts folder ID 7 access to groups 3 and 4.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Id,
        [string]$Name,
        [string]$Description,
        [ValidateSet("all_users","specific")][String]$Security,
        [array]$AllowedGroups,
        [Alias('company_id')]
        [int]$CompanyID
        )
    
    $passwordFolder = Get-HuduPasswordFolders -Id $Id 
    
    $updatePasswordFolder=@{
        name        = $(if ($Name) {$Name} else {$passwordFolder.name})
        description = $(if ($Description) {$Description} else {$passwordFolder.description})
    }
    if ($passwordFolder.company_id){
        $updatePasswordFolder.company_id = $passwordFolder.company_id
    }

    if ($PSBoundParameters.ContainsKey('CompanyID'))   { $passwordFolder.company_id   = $CompanyID }
    
    if (($AllowedGroups -and $AllowedGroups -ne $passwordFolder.allowed_groups) -or ($security -and $security -eq "specific")){
        $updatePasswordFolder["security"] = $security
        $allGroups = $(Get-HuduGroups).id
        if ($($AllowedGroups | where-object {$allGroups -contains $_}).count -gt 1) {
            $updatePasswordFolder["allowed_groups"]= $AllowedGroups | where-object {$allGroups -contains $_}
        } elseif ($passwordFolder.allowed_groups) {
            $updatePasswordFolder["allowed_groups"]= $passwordFolder.allowed_groups
        } else {
            $updatePasswordFolder["allowed_groups"]= @("0")
        }
    } else {
        $updatePasswordFolder["security"] = $passwordFolder.security
        $updatePasswordFolder["allowed_groups"] = $passwordFolder.allowed_groups
    }
    if ($updatePasswordFolder["security"] -eq "all_users"){
        $updatePasswordFolder["allowed_groups"] = @()
    }


    try {
        $res = Invoke-HuduRequest -Method PUT -Resource "/api/v1/password_folders/$ID" -Body $(@{password_folder = $passwordFolder} | ConvertTo-Json -Depth 10)
        return $res
    } catch {
        Write-Warning "Failed to create new password folder '$Name'"
        return $null
    }
}
