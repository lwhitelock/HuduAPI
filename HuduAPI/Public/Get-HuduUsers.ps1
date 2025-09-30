function Get-HuduUsers {
    <#
    .SYNOPSIS
    Get a list of Users

    .DESCRIPTION
    Call Hudu API to retrieve Users

    .PARAMETER Id
    Id of requested users

    .PARAMETER Users
    Name of the requested user

    .PARAMETER CompanyId
    Id of the requested company

    .PARAMETER Name
    Filter by name

    .PARAMETER Archived
    Show archived results

    .PARAMETER Slug
    Filter by slug of user

    .EXAMPLE
    Get-HuduUsers -Name 'Jim'
#>

[CmdletBinding()]
    Param (
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$Id = '',
        [string]$Email = '',
        [string]$First_name = '',
        [string]$Last_name = '',
	    [ValidateRange(1, [int]::MaxValue)]
        [Int]$Portal_member_company_id = '',
	    [String]$Securitylevel = '',
        [string]$Slug = ''
    )

    if ($Id) {
        Invoke-HuduRequest -Method get -Resource "/api/v1/users/$Id"
    } else {
        $Params = @{}

        if ($First_name) { $Params.first_name = $First_name}
        if ($Last_name) { $Params.last_name = $Last_name}
        if ($Email) { $Params.email = $Email}

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/users'
            Params   = $Params
    }

        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property Users
    }
}
