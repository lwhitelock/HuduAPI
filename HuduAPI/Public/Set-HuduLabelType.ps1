function Set-HuduLabelType {
<#
.SYNOPSIS
Updates a Label Type.

.DESCRIPTION
Updates a Label Type by ID. When setting AccessLevel to specific_companies,
AllowedCompanyIds must contain at least one company ID, either from the existing
Label Type or from the provided parameter.

.PARAMETER Id
ID of the Label Type to update.

.PARAMETER Name
Updated name.

.PARAMETER Color
Updated hex color value for the Label Type, such as #1c12a3, or a
human-readable color name supported by Set-ColorFromCanonical. Alpha values are
trimmed off.

.PARAMETER AccessLevel
Updated access scope.

.PARAMETER ApplicableRecordTypes
Updated list of record types this Label Type can be applied to.

.PARAMETER AllowedCompanyIds
Updated list of company IDs allowed to use this Label Type when AccessLevel is specific_companies.

.EXAMPLE
Set-HuduLabelType -Id 1 -Name "AnotherLabel" -Color "scharlachrot"

.EXAMPLE
Set-HuduLabelType -Id 1 -Name "Critical" -Color "#ff0000"

.EXAMPLE
Set-HuduLabelType -Id 1 -Name "Colorful" -Color "naranja" -ApplicableRecordTypes @("asset","motdepasse","internetseite","procédure","netzwerk")

.NOTES
API Endpoint: PUT /api/v1/label_types/{id}
#>

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [Alias('LabelTypeId','label_type_id','labeltype_id','label_typeid','type_id','typeid')]
        [int]$Id,

        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateNotNullOrEmpty()]
        [string]$Color,

        [ValidateSet('all_companies', 'all', 'allcompanies', 'allcompany', 'specific_companies', 'specific', 'specificcompanies', 'specificcompany', IgnoreCase = $true)]
        [Alias('access_level')]
        [string]$AccessLevel,

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

    $object = Get-HuduLabelTypes -Id $Id
    if (-not $object) { return $null }

    if ($PSBoundParameters.ContainsKey('Name')) {
        $object | Add-Member -MemberType NoteProperty -Name name -Force -Value $Name
    }
    if ($PSBoundParameters.ContainsKey('Color')) {
        $object | Add-Member -MemberType NoteProperty -Name color -Force -Value (ConvertTo-HuduLabelColor -Color $Color)
    }
    if ($PSBoundParameters.ContainsKey('AccessLevel')) {
        $normalizedAccessLevel = $AccessLevelMap[$AccessLevel.ToLower()]
        if (-not $normalizedAccessLevel) {
            throw "Invalid AccessLevel value '$AccessLevel'. Valid values are: $($AccessLevelMap.Keys -join ', ')."
        }
        $object | Add-Member -MemberType NoteProperty -Name access_level -Force -Value $normalizedAccessLevel
    }
    if ($PSBoundParameters.ContainsKey('ApplicableRecordTypes')) {
        $recordTypes = @($ApplicableRecordTypes | ForEach-Object { Get-ObjectTypeFromCononical -inputData $_ })
        $object | Add-Member -MemberType NoteProperty -Name applicable_record_types -Force -Value $recordTypes
    }
    if ($PSBoundParameters.ContainsKey('AllowedCompanyIds')) {
        $object | Add-Member -MemberType NoteProperty -Name allowed_company_ids -Force -Value @($AllowedCompanyIds)
    }

    $effectiveAccessLevel = $object.access_level
    $effectiveAllowedCompanyIds = @($object.allowed_company_ids)
    if ($effectiveAccessLevel -eq 'specific_companies' -and -not $effectiveAllowedCompanyIds) {
        throw "AllowedCompanyIds must contain at least one company ID when AccessLevel is specific_companies."
    }

    $body = @{ label_type = $object } | ConvertTo-Json -Depth 99

    if ($PSCmdlet.ShouldProcess("Label Type Id=$Id", "Update")) {
        $resp = Invoke-HuduRequest -Method PUT -Resource "/api/v1/label_types/$Id" -Body $body
        return ($resp.label_type ?? $resp)
    }
}
