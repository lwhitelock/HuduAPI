function Get-HuduExports {
    [CmdletBinding()]
    param(
        [int]$id
    )
    if ($null -ne $id -and $id -ge 1){
        Invoke-HuduRequest -Method 'GET' -Resource "/api/v1/exports/$id"
    } else {
        Invoke-HuduRequest -Method 'GET' -Resource '/api/v1/exports'
    }
}