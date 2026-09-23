function Move-HuduAssetCompany {
    <#
    .SYNOPSIS
    Move an Asset to a different company

    .DESCRIPTION
    Uses Hudu API to update an asset's company_id via PUT /api/v1/companies/{company_id}/assets/{id}

    The company in the URL identifies the asset, so it must be the company that
    currently owns it. That id is looked up from the asset itself; CompanyId is
    the destination and is sent in the body.

    .PARAMETER HuduBaseURL
    Optional Hudu base URL. When provided, it is applied with New-HuduBaseURL before the request.

    .PARAMETER AssetId
    Id of the asset to move

    .PARAMETER CompanyId
    Destination company id

    .EXAMPLE
    Move-HuduAssetCompany -AssetId 1 -CompanyId 20

    .EXAMPLE
    Move-HuduAssetCompany -HuduBaseURL https://demo.huducloud.com -AssetId 1 -CompanyId 20
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter()]
        [Alias('BaseURL')]
        [String]$HuduBaseURL,

        [Alias('asset_id', 'id')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$AssetId,

        [Alias('company_id')]
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]$CompanyId
    )

    if ($HuduBaseURL) {
        New-HuduBaseURL -BaseURL $HuduBaseURL
    }

    # Get-HuduAssets -Id alone queries the collection endpoint, so take the
    # single match rather than letting an array land in the request URL.
    $Object = Get-HuduAssets -Id $AssetId | Select-Object -First 1
    if (-not $Object) {
        throw "A valid asset could not be found to move, please double check the ID and try again"
    }

    if ($null -eq $Object.company_id -or [int]$Object.company_id -lt 1) {
        throw "Asset $AssetId does not have a valid current company_id, so it cannot be moved."
    }

    $CurrentCompanyId = [int]$Object.company_id
    $Asset = [ordered]@{asset = [ordered]@{company_id = $CompanyId } }
    $JSON = $Asset | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess("ID: $AssetId Name: $($Object.name)", "Move Asset from company $CurrentCompanyId to $CompanyId")) {
        $Result = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$CurrentCompanyId/assets/$AssetId" -Body $JSON

        # Invoke-HuduRequest returns $null after a failed retry, so verify the
        # persisted state instead of silently reporting a successful move.
        $MovedAsset = Get-HuduAssets -Id $AssetId | Select-Object -First 1
        if (-not $MovedAsset -or [int]$MovedAsset.company_id -ne $CompanyId) {
            throw "Asset $AssetId did not move to company $CompanyId."
        }

        if ($null -ne $Result) {
            $Result
        } else {
            $MovedAsset
        }
    }
}
