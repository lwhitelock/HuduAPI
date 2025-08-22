function Start-HuduExport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int]$CompanyId,
        [array]$AssetLayoutIDs=$null,
        [bool]$IncludePasswords=$true,
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
