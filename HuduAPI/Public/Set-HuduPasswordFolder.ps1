function Set-HuduPasswordFolder {
    <##>
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Id,
        [string]$Name,
        [string]$Description,
        [ValidateSet("all_users","specific")][String]$Security,
        [array]$AllowedGroups)
    
    $passwordFolder = Get-HuduPasswordFolders -Id $Id 
    
    $updatePasswordFolder=@{
        name        = $(if ($Name) {$Name} else {$passwordFolder.name})
        description = $(if ($Description) {$Description} else {$passwordFolder.description})
        company_id = $passwordFolder.company_id
    }

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
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/password_folders" -Body $(@{password_folder = $updatePasswordFolder} | ConvertTo-Json -Depth 10)
        return $res
    } catch {
        Write-Warning "Failed to create new password folder '$Name'"
        return $null
    }
}


