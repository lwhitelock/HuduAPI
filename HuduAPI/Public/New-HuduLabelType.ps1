function New-HuduLabelType {
<#
.SYNOPSIS
Creates a new Label Type.

.DESCRIPTION
Creates a Label Type that can be applied to records via New-HuduLabel.
applicable_record_types must include one or more valid Hudu record types. When
AccessLevel is specific_companies, AllowedCompanyIds must contain at least one ID.

.PARAMETER Name
Display name for the Label Type.

.PARAMETER Color
Hex color value for the Label Type, such as #ff0000, or a human-readable color
name supported by Set-ColorFromCanonical. Alpha values are trimmed off.

.PARAMETER AccessLevel
Access scope for the Label Type. Defaults to all_companies.

.PARAMETER ApplicableRecordTypes
Record types this Label Type can be applied to. (can be english, spanish, italian)

.PARAMETER AllowedCompanyIds
Company IDs allowed to use this Label Type when AccessLevel is specific_companies.

.EXAMPLE
New-HuduLabelType -Name "Critical" -Color "#ffff00" -ApplicableRecordTypes Asset,Website

.EXAMPLE
New-HuduLabelType -Name "Private" -Color "green" -AccessLevel specific_companies -ApplicableRecordTypes Asset -AllowedCompanyIds 1,2

.EXAMPLE
New-HuduLabelType -Name "Orange" -Color "naranja" -ApplicableRecordTypes @("asset","motdepasse","internetseite","procédure","netzwerk")

.NOTES
API Endpoint: POST /api/v1/label_types
#>

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Color,

        [Parameter()]
        [ValidateSet('all_companies', 'all', 'allcompanies', 'allcompany', 'specific_companies', 'specific', 'specificcompanies', 'specificcompany', IgnoreCase = $true)]
        [Alias('access_level')]
        [string]$AccessLevel = 'all_companies',

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            foreach ($recordType in $_) {
                Assert-AllowedObjectType -InputType $recordType -AllowedCanonicals @(
                    'Article', 'Asset', 'AssetPassword', 'Website', 'IpAddress', 'Vlan', 'VlanZone', 'Procedure', 'Network', 'RackStorage'
                ) | Out-Null
            }
            $true
        })]
        [Alias('applicable_record_types','record_types','types','applicableTypes','applicable_type','applicableType')]
        [string[]]$ApplicableRecordTypes,

        [Parameter()]
        [Alias('allowed_company_ids','companyids','company_ids','companyId','company_id','companies')]
        [int[]]$AllowedCompanyIds
    )
    $AccessLevelMap = @{
        'all_companies'             = 'all_companies'
        'all'                       = 'all_companies'
        'allcompanies'              = 'all_companies'
        'allcompany'                = 'all_companies'
        'specific_companies'        = 'specific_companies'
        'specific'                  = 'specific_companies'
        'specificcompanies'         = 'specific_companies'
        'specificcompany'           = 'specific_companies'
    }
    $accesslevelNormalized = $AccessLevelMap[$AccessLevel.ToLower()]


    if ($accesslevelNormalized -eq 'specific_companies' -and -not $AllowedCompanyIds) {
        throw "AllowedCompanyIds must contain at least one company ID when AccessLevel is specific_companies."
    }

    $labelType = @{
        name                    = $Name
        color                   = ConvertTo-HuduLabelColor -Color $Color
        access_level            = $accesslevelNormalized
        applicable_record_types = @($ApplicableRecordTypes | ForEach-Object { Get-ObjectTypeFromCononical -inputData $_ })
    }

    if ($accesslevelNormalized -eq 'specific_companies') {
        $labelType.allowed_company_ids = @($AllowedCompanyIds)
    }

    $body = @{ label_type = $labelType } | ConvertTo-Json -Depth 99

    if ($PSCmdlet.ShouldProcess("Label Type '$Name'", "Create")) {
        $resp = Invoke-HuduRequest -Method POST -Resource "/api/v1/label_types" -Body $body
        return ($resp.label_type ?? $resp)
    }
}
