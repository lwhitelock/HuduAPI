function New-HuduPasswordFolder {
    <#

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)][int]$CompanyId,
        [string]$Description,
        [ValidateSet("all_users","specific")][String]$Security,
        [array]$AllowedGroups=@())

    $password_folder=@{
        name             = $Name
        company_id       = $CompanyId
    }
    if ($Description){
        $password_folder["description"] = $Description
    }
    if ($security -and $security -eq "specific"){
        $password_folder["security"] = $security
        $allGroups = Get-HuduGroups
        $password_folder["allowed_groups"]= 
            $(if ($null -eq $AllowedGroups -or $AllowedGroups.count -lt 1){
                @($allGroups.id)
            } else {
                $AllowedGroups | where-object {$allGroups -contains $_.id}
            })
    } else {
        $password_folder["security"] = 'all_users'
        $password_folder["allowed_groups"]= 0
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
