function New-HuduExport {
    <#
    .SYNOPSIS
    Start an export of a company

    .DESCRIPTION
    Uses Hudu API to create a company export

    .PARAMETER Format
    Format (pdf,csv,s3)

    .PARAMETER CompanyId
    Company Id

    .PARAMETER IncludePasswords
    Include passwords in export

    .PARAMETER IncludeWebsites
    Include websites in export

    .PARAMETER AssetLayoutIds
    List of asset layout ids

    .PARAMETER AssetLayouts
    Enter a list of Asset Layouts names or 'All'

    .EXAMPLE
    New-HuduExport -Format pdf -CompanyId 1 -IncludePasswords -IncludeWebsites

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('pdf', 'csv', 's3')]
        [string]$Format,

        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $true)]
        [Alias('id')]
        [int]$CompanyId,

        [switch]$IncludePasswords,

        [switch]$IncludeWebsites,

        [Parameter(ParameterSetName = 'LayoutIDs')]
        [int[]]$AssetLayoutIds,

        [Parameter(ParameterSetName = 'LayoutNames')]
        [string[]]$AssetLayouts
    )

    process {
        $Export = [ordered]@{export = [ordered]@{} }

        if ($AssetLayouts) {
            $AssetLayoutList = Get-HuduAssetLayouts
            if ($AssetLayouts -eq 'All') {
                $AssetLayoutIds = $AssetLayoutList | Select-Object -ExpandProperty id
            } else {
                $AssetLayoutIds = foreach ($AssetLayout in $AssetLayouts) {
                    $AssetLayoutList | Where-Object { $_.name -eq $AssetLayout } | Select-Object -ExpandProperty id
                }
            }
        }

        $Export.export.company_id = "$CompanyId"
        $Export.export.format = $Format
        $Export.export.include_passwords = $IncludePasswords.IsPresent
        $Export.export.include_websites = $IncludeWebsites.IsPresent

        if ($AssetLayoutIds) {
            $Export.export.asset_layout_ids = @($AssetLayoutIds)
        }

        $JSON = $Export | ConvertTo-Json -Depth 10

        if ($PSCmdlet.ShouldProcess($CompanyId)) {
            Invoke-HuduRequest -Method post -Resource '/api/v1/exports' -Body $JSON
        }
    }
}
