function Set-HuduPasswordFolder {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [int]$Id,
        [String]$Name,
        [ValidateSet("all_users","specific")][String]$Security,
        [array]$AllowedGroups   
    )

    $passwordFolder = Get-HuduPasswordFolder -id $Id
    
    $params = @{}
    if ($Name)          { $Params.name = $Name }
    if ($Security)      { $Params.security = $Security }
    if ($AllowedGroups) { $Params.allowed_groups = $AllowedGroups }

    $HuduRequest = @{
        Method   = 'PUT'
        Resource = '/api/v1/password_folders'
        Params   = $Params
    }
    Invoke-HuduRequest
}
