function Start-HuduExport {
    <#
    .SYNOPSIS
    Initiate a PDF or CSV backup of Hudu Data for a given company

    .DESCRIPTION
    Uses Hudu API to initiate a backup for a company

    .PARAMETER CompanyId
    Company Identifier for company you wish to initiate export for

    .PARAMETER AssetLayoutIDs
    Optional- List/Array for Layout Identifiers you'd like to include in backup, defaults to all

    .PARAMETER IncludePasswords
    Include Passwords in export, true/false (defaults to false if not provided)

    .PARAMETER IncludeWebsites
    Include Websites in export, true/false (defaults to true if not provided)

    .PARAMETER format
    format desired for export (csv or pdf)
    #>    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int]$CompanyId,
        [array]$AssetLayoutIDs=$null,
        [bool]$IncludePasswords=$false,
        [bool]$IncludeWebsites=$true,
        [ValidateSet("pdf","csv","PDF","CSV")][string]$format='pdf'
    )
    if ($null -eq $AssetLayoutIDs -or $AssetLayoutIDs.count -lt 1){
        $AssetLayoutIDs =  $(get-huduAssetLayouts).id
    }
    $payload = @{
        export = @{
            include_websites        = "$($IncludeWebsites)".ToLower()
            include_passwords       = "$($IncludePasswords)".ToLower()
            company_id              = $CompanyId
            format                  = "$($format)".ToLower()
            asset_layout_ids        = @($AssetLayoutIDs)
        }} | ConvertTo-Json -Depth 10
    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/exports" -Body $payload
        return $res
    } catch {
        Write-Warning "Failed to initiate backup for company $CompanyID- $_"
    }
}
