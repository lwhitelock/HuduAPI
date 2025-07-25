function Get-HuduList {
    [CmdletBinding()]
    param(
        [string]$Name
    )

    $response = Invoke-HuduRequest -Method GET -Resource "/api/v1/lists"

    if (-not $response) {
        Write-Warning "⚠️ No lists returned from Hudu."
        return $null
    }

    # Flat array (not wrapped)
    $lists = $response

    if ($Name) {
        $filtered = $lists | Where-Object { $_.name -eq $Name }
        if ($filtered) {
            return $filtered
        } else {
            Write-Warning "No list found with name '$Name'"
            return $null
        }
    }

    return $lists
}