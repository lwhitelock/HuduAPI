function Get-HuduMagicDashes {
    <#
    .SYNOPSIS
    Get all Magic Dash Items

    .DESCRIPTION
    Call Hudu API to retrieve Magic Dashes

    .PARAMETER CompanyId
    Filter by company id

    .PARAMETER Title
    Filter by title

    .EXAMPLE
    Get-HuduMagicDashes -Title 'Microsoft 365 - ...'

    #>
    Param (
        [Alias('company_id')]
        [Int]$CompanyId,
        [String]$Title
    )

    $Params = @{}

    if ($CompanyId) { $Params.company_id = $CompanyId }
    if ($Title) { $Params.title = $Title }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/magic_dash'
        Params   = $Params
    }
    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest
}
