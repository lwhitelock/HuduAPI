function New-HuduPasswordFolder {
    <#
    .SYNOPSIS
    Create a new password folder.

    .DESCRIPTION
    Calls the Hudu API to create a password folder for a given company.  
    Supports configuring name, description, security settings, and allowed groups.

    .PARAMETER Name
    Name of the new folder (required).

    .PARAMETER CompanyId
    The company ID that owns the folder (required).

    .PARAMETER Description
    Description of the folder.

    .PARAMETER Security
    Security mode. Accepts "all_users" or "specific".

    .PARAMETER AllowedGroups
    Array of group IDs that should have access (if Security is "specific").

    .EXAMPLE
    New-HuduPasswordFolder -Name "Infrastructure" -CompanyId 2
    Creates a folder named "Infrastructure" for company ID 2.

    .EXAMPLE
    New-HuduPasswordFolder -Name "Finance" -CompanyId 4 -Security specific -AllowedGroups @(10,12)
    Creates a folder for company 4 restricted to groups 10 and 12.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
        [int]$CompanyId,
        [string]$Description,
        [ValidateSet("all_users","specific")][String]$Security,
        [array]$AllowedGroups)

    $password_folder=@{
        name = $Name
    }
    if ($PSBoundParameters.ContainsKey('CompanyId')) {
        $password_folder.company_id = $CompanyId
    } else {
        # Assumed to be global password folder if not provided
        $password_folder.company_id = $null
    }
    if ($Description){
        $password_folder["description"] = $Description
    }
    if ($security -and $security -eq "specific"){
        $password_folder["security"] = $security
        $allGroups = $(Get-HuduGroups).id
        
        if ($($AllowedGroups | where-object {$allGroups -contains $_}).count -gt 0) {
            $password_folder["allowed_groups"]= $AllowedGroups | where-object {$allGroups -contains $_}
        } else {
            $password_folder["allowed_groups"]=@("0")
        }
    } else {
        $password_folder["security"] = 'all_users'
        $password_folder["allowed_groups"]= @()
    }
    $payload = @{password_folder = $password_folder} | ConvertTo-Json -Depth 10
    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/password_folders" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to create new password folder '$Name'"
        return $null
    }
}
