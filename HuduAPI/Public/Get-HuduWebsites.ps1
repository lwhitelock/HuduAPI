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

    .PARAMETER UpdatedAfter
    Get Websites Refreshed or Monitored After X datetime
    
    .PARAMETER UpdatedBefore
    Get Websites Refreshed or Monitored Before Y datetime

	.EXAMPLE
	Get-HuduWebsites -Search 'domain.com'
    Get-HuduWebsites -UpdatedAfter $(get-date).AddMinutes(-12)
    Get-HuduWebsites -UpdatedBefore $(get-date).AddDays(-7)

	#>
    [CmdletBinding()]
    Param (
        [String]$Name,
        [Alias('website_id','Id')]
        [Int]$WebsiteId,
        [String]$Slug,
        [string]$Search,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore
    )

    if ($WebsiteId) {
        Invoke-HuduRequest -Method get -Resource "/api/v1/websites/$($WebsiteId)"
    } else {
        $Params = @{}
        if ($Name) { $Params.name = $Name }
        if ($Slug) { $Params.slug = $Slug }
        if ($Search) { $Params.search = $Search }
        $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
        if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
            $Params.updated_at = $updatedRange
        }
        $HuduRequest = @{
            Method   = 'GET'
            Resource = '/api/v1/websites'
            Params   = $Params
        }
        Invoke-HuduRequestPaginated -HuduRequest $HuduRequest
    }
}
