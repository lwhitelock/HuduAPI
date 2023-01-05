function Get-HuduAppInfo {
    [CmdletBinding()]
    Param()
    try {
    
        $HuduAPIKey = Get-HuduApiKey
        $HuduBaseURL = Get-HuduBaseURL
	
        $version = Invoke-RestMethod -method get -uri ($HuduBaseURL + "/api/v1/api_info") `
            -headers @{'x-api-key' = (New-Object PSCredential "user", $HuduAPIKey).GetNetworkCredential().Password; } `
            -ContentType 'application/json'
		

    } catch {
        $version = @{
            version = "0.0.0.0"
            date    = "2000-01-01"
        }
    }


    return $Version
	
}