function Get-HuduWebsites {
    <#
	.SYNOPSIS
	Get a list of all websites

	.DESCRIPTION
	Calls Hudu API to get websites

	.PARAMETER Name
	Filter websites by name

	.PARAMETER Id
	ID of website

	.PARAMETER Slug
	Filter by url slug

    .PARAMETER Search
    Fitler by search query

    .PARAMETER StartDate
    Filter by updated_at property

    .PARAMETER EndDate
    Filter by updated_at property

    .PARAMETER ExactDate
    Filter by updated_at property

	.EXAMPLE
	Get-HuduWebsites -Search 'domain.com'

	#>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    Param (
        [Parameter(ParameterSetName = 'List')]
        [String]$Name,

        [Parameter(ParameterSetName = 'Single')]
        [Alias('website_id')]
        [Int]$WebsiteId,

        [Parameter(ParameterSetName = 'List')]
        [String]$Slug,

        [Parameter(ParameterSetName = 'List')]
        [string]$Search,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$StartDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$EndDate,

        [Parameter(ParameterSetName = 'List')]
        [DateTime]$ExactDate
    )

    if ($WebsiteId) {
        Invoke-HuduRequest -Method get -Resource "/api/v1/websites/$($WebsiteId)"
    } else {
        $Params = @{}
        if ($Name) { $Params.name = $Name }
        if ($Slug) { $Params.slug = $Slug }
        if ($Search) { $Params.search = $Search }

        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/websites'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest
    }
}
