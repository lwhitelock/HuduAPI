function Get-HuduFeatureAvailability {
    <#
    .SYNOPSIS
    Safely Determine if a Core Hudu Feature is Available

    .DESCRIPTION
    Uses Hudu API to query core objects to determine their accessibility.
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('corefeature')]
        [ValidateScript({Assert-AllowedObjectType -InputType $_ -AllowedCanonicals @(
                "VlanZone", "Vlan", "Procedure", "Website", "RackStorage", "Network", "IpAddress", "Article", "Company", "Asset", "AssetPassword", "Photo","PublicPhoto","Racks"
        )})][String]$Core_Feature
    )

    $ObjectType = "$(Get-ObjectTypeFromCononical -inputData $Core_Feature)"
    if ($ObjectType -eq 'Article') {
        return Test-HuduArticleFeatureAvailability
    }

    $Resource = switch ($ObjectType) {
        "VlanZone"      { "/api/v1/ip_addresses" }
        "Vlan"          { "/api/v1/ip_addresses" }
        "IpAddress"     { "/api/v1/ip_addresses" }
        "Network"       { "/api/v1/ip_addresses" }

        "Procedure"     { "/api/v1/procedures" }
        "Website"       { "/api/v1/websites" }
        "RackStorage"   { "/api/v1/rack_storages" }
        "PublicPhoto"   { "/api/v1/public_photos" }
        "Photo"         { "/api/v1/photos" }
        "Article"       { "/api/v1/articles" }
        "Company"       { "/api/v1/companies" }
        "Asset"         { "/api/v1/assets" }
        "AssetPassword" { "/api/v1/asset_passwords" }
        default          { throw "Unsupported core feature: $Core_Feature" }
    }

    try {
        $Result = Invoke-HuduFeatureAvailabilityProbe -Resource $Resource
        return -not (Test-HuduFeatureDisabledMessage -InputObject $Result)
    } catch {
        if (Test-HuduFeatureDisabledMessage -InputObject $_) {
            return $false
        }

        if ($ObjectType -eq 'AssetPassword' -and (Test-HuduFeatureAvailabilityBadCredentials -InputObject $_)) {
            Write-Verbose 'Password feature availability probe returned Bad credentials. Treating passwords as unavailable for this API key/instance.'
            return $false
        }

        throw
    }
}

function Invoke-HuduFeatureAvailabilityProbe {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Resource,

        [hashtable]$Params = @{},

        [ValidateSet('GET', 'POST', 'DELETE')]
        [string]$Method = 'GET',

        [string]$Body
    )

    $ParamCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
    $QueryParams = @{}
    
    if ($Method -eq 'GET' -and $Resource -notlike '/api/v1/ip_addresses*') { # ip addresses / ipam not paginated
        $QueryParams.page = '1'
        $QueryParams.page_size = '1'
    }

    foreach ($Item in $Params.GetEnumerator()) {
        $QueryParams[$Item.Key] = $Item.Value
    }

    foreach ($Item in ($QueryParams.GetEnumerator() | Sort-Object -CaseSensitive -Property Key)) {
        $ParamCollection.Add($Item.Key, $Item.Value)
    }

    $UriBuilder = [System.UriBuilder]('{0}{1}' -f (Get-HuduBaseURL), $Resource)
    $UriBuilder.Query = $ParamCollection.ToString()

    Invoke-HuduFeatureAvailabilityRequest -Method $Method -Uri $UriBuilder.Uri -Body $Body
}

function Invoke-HuduFeatureAvailabilityRequest {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('GET', 'POST', 'DELETE')]
        [string]$Method,

        [Parameter(Mandatory = $true)]
        [uri]$Uri,

        [string]$Body
    )

    $HuduAPIKey = Get-HuduApiKey
    $Headers = @{
        'x-api-key' = (New-Object PSCredential 'user', $HuduAPIKey).GetNetworkCredential().Password
    }

    if (($Script:Int_HuduCustomHeaders | Measure-Object).count -gt 0) {
        foreach ($Entry in $Int_HuduCustomHeaders.GetEnumerator()) {
            $Headers[$Entry.Name] = $Entry.Value
        }
    }

    $Request = @{
        Method      = $Method
        Uri         = $Uri
        Headers     = $Headers
        ContentType = 'application/json; charset=utf-8'
        ErrorAction = 'Stop'
    }

    if ($Body) {
        $Request.Body = $Body
    }

    Invoke-RestMethod @Request
}

function Test-HuduArticleFeatureAvailability {
    [CmdletBinding()]
    Param ()

    $CentralAvailable = Test-HuduArticleScopeFeatureAvailability -TreatServerErrorAsUnavailable

    $CompanyId = Get-HuduFeatureAvailabilityProbeCompanyId
    if (-not $CompanyId) {
        $ProbeCompany = $null
        try {
            $ProbeCompany = New-HuduFeatureAvailabilityProbeCompany
            $companyArticleAvailable = Test-HuduArticleScopeFeatureAvailability -Params @{ company_id = $ProbeCompany.id } -TreatServerErrorAsUnavailable
        } catch {
            $companyArticleAvailable = $false
        } finally {
            if ($ProbeCompany -and $ProbeCompany.id) {
                Remove-HuduFeatureAvailabilityProbeCompany -Id $ProbeCompany.id
            }
        }
    } else {
        $companyArticleAvailable = Test-HuduArticleScopeFeatureAvailability -Params @{ company_id = $CompanyId } -TreatServerErrorAsUnavailable
    }

    return [PSCustomObject]@{
        CompanyKB = $companyArticleAvailable
        CentralKB = $CentralAvailable
    }
}

function Test-HuduArticleScopeFeatureAvailability {
    [CmdletBinding()]
    Param (
        [hashtable]$Params = @{},

        [switch]$TreatServerErrorAsUnavailable
    )

    Test-HuduArticleCreateProbeResult -Params $Params -TreatServerErrorAsUnavailable:$TreatServerErrorAsUnavailable
}

function Test-HuduArticleCreateProbeResult {
    [CmdletBinding()]
    Param (
        [hashtable]$Params = @{},

        [switch]$TreatServerErrorAsUnavailable
    )

    $Article = [ordered]@{
        article = [ordered]@{
            name      = 'hudu-feature-availability-probe'
            content   = 'Temporary article probe created by Get-HuduFeatureAvailability.'
            folder_id = -1
        }
    }

    if ($Params.ContainsKey('company_id')) {
        $Article.article.Add('company_id', $Params.company_id)
    }

    try {
        $Result = Invoke-HuduFeatureAvailabilityProbe -Resource '/api/v1/articles' -Method POST -Body ($Article | ConvertTo-Json -Depth 10)
        Remove-HuduFeatureAvailabilityProbeArticle -InputObject $Result
        return -not (Test-HuduFeatureDisabledMessage -InputObject $Result)
    } catch {
        if (Test-HuduFeatureDisabledMessage -InputObject $_) {
            Write-Verbose 'Article create probe returned a disabled-feature response.'
            return $false
        }

        if (Test-HuduFeatureAvailabilityValidationError -InputObject $_) {
            Write-Verbose 'Article create probe reached validation, so the article feature is available.'
            return $true
        }

        if ($TreatServerErrorAsUnavailable.IsPresent -and (Test-HuduFeatureAvailabilityServerError -InputObject $_)) {
            Write-Verbose ("Article create probe returned a server error response: {0}" -f (Get-HuduFeatureAvailabilityDetails -InputObject $_))
            return $false
        }

        throw
    }
}

function Remove-HuduFeatureAvailabilityProbeArticle {
    [CmdletBinding()]
    Param (
        [AllowNull()]
        [object]$InputObject
    )

    if ($null -eq $InputObject) {
        return
    }

    $Article = $InputObject.article ?? $InputObject
    if (-not $Article -or -not $Article.id) {
        return
    }

    $Uri = [System.Uri]('{0}/api/v1/articles/{1}' -f (Get-HuduBaseURL).TrimEnd('/'), $Article.id)
    try {
        $null = Invoke-HuduFeatureAvailabilityRequest -Method DELETE -Uri $Uri
    } catch {
        Write-Warning "Failed to delete temporary Hudu feature availability probe article id $($Article.id). Delete it manually. $($_.Exception.Message)"
    }
}

function New-HuduFeatureAvailabilityProbeCompany {
    [CmdletBinding()]
    Param ()

    $Name = 'hudu-feature-availability-probe-{0}' -f ([guid]::NewGuid().ToString('N').Substring(0, 12))
    $Company = [ordered]@{
        company = [ordered]@{
            name  = $Name
            notes = 'Temporary company created by Get-HuduFeatureAvailability to probe company-scoped KB availability.'
        }
    }

    $Uri = [System.Uri]('{0}/api/v1/companies' -f (Get-HuduBaseURL).TrimEnd('/'))
    $Result = Invoke-HuduFeatureAvailabilityRequest -Method POST -Uri $Uri -Body ($Company | ConvertTo-Json -Depth 10)
    $ProbeCompany = $Result.company ?? $Result

    if (-not $ProbeCompany -or -not $ProbeCompany.id) {
        throw 'Failed to create temporary Hudu company for feature availability probe.'
    }

    return $ProbeCompany
}

function Remove-HuduFeatureAvailabilityProbeCompany {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [int]$Id
    )

    $Uri = [System.Uri]('{0}/api/v1/companies/{1}' -f (Get-HuduBaseURL).TrimEnd('/'), $Id)
    try {
        $null = Invoke-HuduFeatureAvailabilityRequest -Method DELETE -Uri $Uri
    } catch {
        Write-Warning "Failed to delete temporary Hudu feature availability probe company id $Id. Delete it manually. $($_.Exception.Message)"
        throw
    }
}

function Test-HuduFeatureAvailabilityProbeResult {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Resource,

        [hashtable]$Params = @{},

        [switch]$TreatServerErrorAsUnavailable
    )

    try {
        $Result = Invoke-HuduFeatureAvailabilityProbe -Resource $Resource -Params $Params
        return -not (Test-HuduFeatureDisabledMessage -InputObject $Result)
    } catch {
        if (Test-HuduFeatureDisabledMessage -InputObject $_) {
            Write-Verbose ("Feature availability probe for {0} returned a disabled-feature response." -f $Resource)
            return $false
        }

        if ($TreatServerErrorAsUnavailable.IsPresent -and (Test-HuduFeatureAvailabilityServerError -InputObject $_)) {
            Write-Verbose ("Feature availability probe for {0} returned a server error response: {1}" -f $Resource, (Get-HuduFeatureAvailabilityDetails -InputObject $_))
            return $false
        }

        throw
    }
}

function Get-HuduFeatureAvailabilityProbeCompanyId {
    [CmdletBinding()]
    Param ()

    $Result = Invoke-HuduFeatureAvailabilityProbe -Resource '/api/v1/companies'
    $Companies = @($Result.companies)

    if (-not $Companies) {
        $Companies = @($Result)
    }

    $Company = $Companies | Where-Object { $null -ne $_.id } | Select-Object -First 1
    if ($Company) {
        return $Company.id
    }

    return $null
}

function Test-HuduFeatureDisabledMessage {
    [CmdletBinding()]
    Param (
        [AllowNull()]
        [object]$InputObject
    )

    $Details = Get-HuduFeatureAvailabilityDetails -InputObject $InputObject
    return (
        $Details -ilike '*disabled for this instance*' -or
        $Details -imatch '(?m)"error"\s*:\s*"[^"]+\s+is disabled"' -or
        $Details -imatch '(?m)\b[\w\s/-]+\s+is disabled\b' -or
        $Details -imatch '(?m)\b[\w\s/-]+\s+(is\s+)?turned off\b' -or
        $Details -imatch '(?m)\b[\w\s/-]+\s+is not enabled\b'
    )
}

function Test-HuduFeatureAvailabilityServerError {
    [CmdletBinding()]
    Param (
        [AllowNull()]
        [object]$InputObject
    )

    $Details = Get-HuduFeatureAvailabilityDetails -InputObject $InputObject
    return (
        $Details -ilike '*500*Internal Server Error*' -or
        $Details -ilike '*InternalServerError*' -or
        $Details -ilike '*Response status code does not indicate success: 500*'
    )
}

function Test-HuduFeatureAvailabilityValidationError {
    [CmdletBinding()]
    Param (
        [AllowNull()]
        [object]$InputObject
    )

    $Details = Get-HuduFeatureAvailabilityDetails -InputObject $InputObject
    return (
        $Details -ilike '*422*' -or
        $Details -ilike '*Unprocessable Entity*' -or
        $Details -ilike '*unprocessable_entity*' -or
        $Details -ilike '*validation*' -or
        $Details -ilike '*can''t be blank*' -or
        $Details -ilike '*cannot be blank*' -or
        $Details -ilike '*is too short*' -or
        $Details -ilike '*param is missing*' -or
        $Details -ilike '*value is empty*' -or
        $Details -ilike '*required parameter*'
    )
}

function Test-HuduFeatureAvailabilityBadCredentials {
    [CmdletBinding()]
    Param (
        [AllowNull()]
        [object]$InputObject
    )

    $Details = Get-HuduFeatureAvailabilityDetails -InputObject $InputObject
    return ($Details -imatch '(?m)\bBad credentials\b')
}

function Get-HuduFeatureAvailabilityDetails {
    [CmdletBinding()]
    Param (
        [AllowNull()]
        [object]$InputObject
    )

    if ($null -eq $InputObject) {
        return ''
    }

    $Parts = [System.Collections.Generic.List[string]]::new()

    if ($InputObject -is [System.Management.Automation.ErrorRecord]) {
        Add-HuduFeatureAvailabilityDetail -Parts $Parts -Value $InputObject.Exception.Message
        Add-HuduFeatureAvailabilityDetail -Parts $Parts -Value $InputObject.ErrorDetails
        Add-HuduFeatureAvailabilityDetail -Parts $Parts -Value $InputObject.ErrorDetails.Message
        Add-HuduFeatureAvailabilityDetail -Parts $Parts -Value $InputObject.Exception.Response
        Add-HuduFeatureAvailabilityDetail -Parts $Parts -Value (Get-HuduFeatureAvailabilityResponseBody -Response $InputObject.Exception.Response)
    } else {
        Add-HuduFeatureAvailabilityDetail -Parts $Parts -Value $InputObject
    }

    return ($Parts -join "`n")
}

function Add-HuduFeatureAvailabilityDetail {
    Param (
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[string]]$Parts,

        [AllowNull()]
        [object]$Value
    )

    if ($null -eq $Value) {
        return
    }

    if ($Value -is [string]) {
        if (-not [string]::IsNullOrWhiteSpace($Value)) {
            $Parts.Add($Value)
        }
        return
    }

    try {
        $Json = $Value | ConvertTo-Json -Depth 20 -Compress -ErrorAction Stop
        if (-not [string]::IsNullOrWhiteSpace($Json)) {
            $Parts.Add($Json)
        }
    } catch {
        $StringValue = $Value.ToString()
        if (-not [string]::IsNullOrWhiteSpace($StringValue)) {
            $Parts.Add($StringValue)
        }
    }
}

function Get-HuduFeatureAvailabilityResponseBody {
    Param (
        [AllowNull()]
        [object]$Response
    )

    if ($null -eq $Response) {
        return $null
    }

    try {
        if ($Response.Content -and ($Response.Content | Get-Member -Name ReadAsStringAsync -MemberType Method)) {
            return $Response.Content.ReadAsStringAsync().GetAwaiter().GetResult()
        }
    } catch {
        return $null
    }

    try {
        if ($Response.GetType().GetMethod('GetResponseStream')) {
            $Stream = $Response.GetResponseStream()
            if ($null -eq $Stream) {
                return $null
            }

            $Reader = [System.IO.StreamReader]::new($Stream)
            try {
                return $Reader.ReadToEnd()
            } finally {
                $Reader.Dispose()
            }
        }
    } catch {
        return $null
    }

    return $null
}
