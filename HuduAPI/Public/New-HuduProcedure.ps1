function New-HuduProcedure {
    <#
    .SYNOPSIS
    Create a new Hudu procedure (process)

    .DESCRIPTION
    Calls the Hudu API to create a procedure without tasks.

    .PARAMETER Name
    Name of the procedure

    .PARAMETER Description
    Description text for the procedure

    .PARAMETER CompanyId
    ID of the company the procedure belongs to

    .PARAMETER CompanyTemplate
    If true, this will create a company template instead of a company procedure

    .EXAMPLE
    New-HuduProcedure -Name "Onboarding" -Description "New employee onboarding" -CompanyId 123
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string]$Name,
        [string]$Description,
        [int]$CompanyId,
        [bool]$CompanyTemplate
    )

    $payload = @{
        name             = $Name
        description      = $Description
        company_id       = $CompanyId
        company_template = $CompanyTemplate
    } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/procedures" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to create procedure '$Name'"
        return $null
    }
}
