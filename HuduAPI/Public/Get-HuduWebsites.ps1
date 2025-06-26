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

	.EXAMPLE
	Get-HuduWebsites -Search 'domain.com'

	#>
    [CmdletBinding()]
    Param (
        [String]$Name,
        [Alias('website_id','Id')]
        [Int]$WebsiteId,
        [String]$Slug,
        [string]$Search
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
