function Invoke-HuduRequest {
    <#
    .SYNOPSIS
    Main Hudu API function

    .DESCRIPTION
    Calls Hudu API with token

    .PARAMETER Method
    GET,POST,DELETE,PUT,etc

    .PARAMETER Params
    Hashtable of parameters

    .PARAMETER Body
    JSON encoded body string

    .PARAMETER Form
    Multipart form data

    .EXAMPLE
    Invoke-HuduRequest -Resource '/api/v1/articles' -Method GET
    #>
    [CmdletBinding()]
    Param(
        [Parameter()]
        [string]$Method = 'GET',

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Resource,

        [Parameter()]
        [hashtable]$Params = @{},

        [Parameter()]
        [string]$Body,

        [Parameter()]
        [hashtable]$Form  
    )

    $HuduAPIKey = Get-HuduApiKey
    $HuduBaseURL = Get-HuduBaseURL

    # Assemble parameters
    $ParamCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)

    # Sort parameters
    foreach ($Item in ($Params.GetEnumerator() | Sort-Object -CaseSensitive -Property Key)) {
        $ParamCollection.Add($Item.Key, $Item.Value)
    }

    # Query string
    $Request = $ParamCollection.ToString()

    $Headers = @{
        'x-api-key' = (New-Object PSCredential 'user', $HuduAPIKey).GetNetworkCredential().Password;
    }

    if (($Script:Int_HuduCustomHeaders | Measure-Object).count -gt 0){
        
        foreach($Entry in $Int_HuduCustomHeaders.GetEnumerator()) {
            $Headers[$Entry.Name] = $Entry.Value
        }
    }

    $ContentType = 'application/json; charset=utf-8'

    $Uri = '{0}{1}' -f $HuduBaseURL, $Resource
    # Make API call URI
    if ($Request) {
        $UriBuilder = [System.UriBuilder]$Uri
        $UriBuilder.Query = $Request
        $Uri = $UriBuilder.Uri
    }
    Write-Verbose ( '{0} [{1}]' -f $Method, $Uri )

    # One session for every request, so calls reuse the connection instead of a new TCP and TLS handshake each time
    if (-not $Script:Int_HuduWebSession) { $Script:Int_HuduWebSession = [Microsoft.PowerShell.Commands.WebRequestSession]::new() }

    $RestMethod = @{
        Method      = $Method
        Uri         = $Uri
        Headers     = $Headers
        ContentType = $ContentType
        WebSession  = $Script:Int_HuduWebSession
    }

    if ($Body) {
        $RestMethod.Body = $Body
        Write-Verbose $Body
    }

    if ($Form) {
        $RestMethod.Form = $Form
        Write-Verbose ( $Form | Out-String )
    }

    try {
        $Results = Invoke-RestMethod @RestMethod
    } catch {
        $errorMessage = $_.Exception.Message
        if ($errorMessage -ilike '*Retry later*' -or $errorMessage -ilike '*429*Too Many Requests*') {
            $windowLength = $script:HAPI_RATE_LIMIT_WINDOW_SECONDS ?? 300
            $secondsIntoWindow = [int][math]::Floor((Get-Date).TimeOfDay.TotalSeconds) % $windowLength
            $secondsUntilNextWindow = [math]::Max(0, $windowLength - $secondsIntoWindow)

            $jitter = Get-Random -Minimum 1 -Maximum 5
            $totalSleep = [math]::Max(0, $secondsUntilNextWindow + $jitter)
            Write-Host "Hudu API Rate limited; Sleeping for $totalSleep seconds to wait for next rate limit window..."
            Start-Sleep -Seconds $totalSleep
        } elseif ($errorMessage -ilike '*Not Found*') {
            return $null
        } else {
            if ($script:SKIP_HAPI_ERROR_RETRY -and $true -eq $script:SKIP_HAPI_ERROR_RETRY) { Write-Error "$_"; return $null }
            if ($script:SKIP_HAPI_POST_RETRY -and $Method -eq 'POST') { Write-Error "$_"; return $null }
            Write-APIErrorObject -name "$($resource ?? 'general')-$($method ?? 'unknown')" -ErrorObject @{
                exception = $_
                request = "$Method $Uri"
                resolution = "Trying again in $($script:HAPI_RETRY_DELAY_SECONDS ?? 5) seconds."
            }
            Start-Sleep -Seconds ($script:HAPI_RETRY_DELAY_SECONDS ?? 5)
        }

        try {
            $Results = Invoke-RestMethod @RestMethod
        } catch {
            Write-APIErrorObject -name "$($resource ?? 'general')-$($method ?? 'unknown')-retry" -ErrorObject @{
                exception = $_
                request = "$Method $Uri"
                resolution = "Retry failed as well. Handle this error here or avoid it prior."
            }
            Write-Error "$_"
            return $null
        }
    }


    $Results
}
