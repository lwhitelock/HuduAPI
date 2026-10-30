function Move-HuduAssetCompany {
    <#
    .SYNOPSIS
    Move an Asset to a different company

    .DESCRIPTION
    Uses Hudu API to update an asset's company_id via PUT /api/v1/companies/{company_id}/assets/{id}

    The company in the URL identifies the asset, so it must be the company that
    currently owns it. That id is looked up from the asset itself; CompanyId is
    the destination and is sent in the body.

    .PARAMETER AssetId
    Id of the asset to move

    .PARAMETER CompanyId
    Destination company id

    .EXAMPLE
    Move-HuduAssetCompany -AssetId 1 -CompanyId 20

    .EXAMPLE
    Move-HuduAssetCompany -AssetId 1 -CompanyId 44
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Alias('asset_id', 'id')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$AssetId,

        [Alias('company_id','new_company_id','destination_company_id','target_company_id')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$CompanyId
    )

    # Get-HuduAssets -Id alone queries the collection endpoint, so take the single match rather than letting an array land in the request URL.
    $Object = Get-HuduAssets -Id $AssetId | Select-Object -First 1
    if (-not $Object) {
        throw "A valid asset could not be found to move, please double check the ID and try again"
    }

    $CurrentCompanyId = $Object.company_id
    $Asset = [ordered]@{asset = [ordered]@{company_id = $CompanyId } }
    $JSON = $Asset | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess("ID: $AssetId Name: $($Object.name)", "Move Asset from company $CurrentCompanyId to $CompanyId")) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CurrentCompanyId/assets/$AssetId" -Body $JSON
    }
}
