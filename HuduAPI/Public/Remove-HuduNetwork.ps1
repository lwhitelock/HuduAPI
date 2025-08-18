function Remove-HuduNetwork {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Id
    )

    try {
        Invoke-HuduRequest -Method DELETE -Resource "/api/v1/networks/$Id"
        Write-Host "Successfully deleted network ID $Id" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to delete network ID $Id"
    }
}