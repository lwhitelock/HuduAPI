

function Get-HuduNetworks {
    [CmdletBinding()]
    param (
        [int]$Id,
        [int]$CompanyId,
        [string]$Slug,
        [string]$Name,
        [int]$NetworkType,
        [string]$Address,
        [int]$LocationID,
        [bool]$Archived,
        [datetime]$CreatedAfter,
        [datetime]$CreatedBefore,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore
    )

    $BaseResource = "/api/v1/networks"

    $Params = @{}
    if ($CompanyId) { $Params["company_id"] = $CompanyId }
    if ($Slug) { $Params["slug"] = $Slug }
    if ($Name) { $Params["name"] = $Name }
    if ($NetworkType) { $Params["network_type"] = $NetworkType }
    if ($Address) { $Params["address"] = $Address }
    if ($LocationID) { $Params["location_id"] = $LocationID }
    if ($Archived) { $Params["archived"] = $Archived }

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($createdRange -ne ',' -and -$null -ne $createdRange) {
        $Params.created_at = $createdRange
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
        $Params.updated_at = $updatedRange
    }
    
    $HuduRequest = if ($Id) {
        @{
            Method   = 'GET'
            Resource = "$BaseResource/$Id"
        }
    } else {
        @{
            Method   = 'GET'
            Resource = "$BaseResource"
            Params   = if ($Params.Count -gt 0) { $Params } else { $null }
        }
    }

    Invoke-HuduRequest @HuduRequest
}
