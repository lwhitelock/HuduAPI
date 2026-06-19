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
Updated exact color value, such as #ff0000.

.PARAMETER AccessLevel
Updated access scope.

.PARAMETER ApplicableRecordTypes
Updated list of record types this Label Type can be applied to.

.PARAMETER AllowedCompanyIds
Updated list of company IDs allowed to use this Label Type when AccessLevel is specific_companies.

.EXAMPLE
Set-HuduLabelType -Id 1 -Name "Critical" -Color "#ff0000"

.EXAMPLE
Set-HuduLabelType -Id 1 -AccessLevel specific_companies -AllowedCompanyIds 1,2

.NOTES
API Endpoint: PUT /api/v1/label_types/{id}
#>

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [Alias('LabelTypeId','label_type_id')]
        [int]$Id,

        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateNotNullOrEmpty()]
        [string]$Color,

        [ValidateSet('all_companies', 'specific_companies')]
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
        [Alias('applicable_record_types')]
        [string[]]$ApplicableRecordTypes,

        [Alias('allowed_company_ids')]
        [int[]]$AllowedCompanyIds
    )

    $object = Get-HuduLabelTypes -Id $Id
    if (-not $object) { return $null }

    if ($PSBoundParameters.ContainsKey('Name')) {
        $object | Add-Member -MemberType NoteProperty -Name name -Force -Value $Name
    }
    if ($PSBoundParameters.ContainsKey('Color')) {
        $object | Add-Member -MemberType NoteProperty -Name color -Force -Value $Color
    }
    if ($PSBoundParameters.ContainsKey('AccessLevel')) {
        $object | Add-Member -MemberType NoteProperty -Name access_level -Force -Value $AccessLevel
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
