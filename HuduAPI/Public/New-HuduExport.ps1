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

        [int[]]$AssetLayoutIds
    )

    process {
        $Export = [ordered]@{export = [ordered]@{} }

        $Export.company_id = $CompanyId
        $Export.format = $Format
        $Export.include_passwords = $IncludePasswords.IsPresent
        $Export.include_websites = $IncludeWebsites.IsPresent

        if ($AssetLayoutIds) {
            $Export.asset_layout_ids = $AssetLayoutIds
        }

        $JSON = $Export | ConvertTo-Json -Depth 10
        Write-Verbose $JSON

        if ($PSCmdlet.ShouldProcess($Name)) {
            Invoke-HuduRequest -Method post -Resource '/api/v1/exports' -Body $JSON
        }
    }
}
