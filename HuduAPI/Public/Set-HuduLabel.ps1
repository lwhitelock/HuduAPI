function Set-HuduLabel {
<#
.SYNOPSIS
Updates a Label.

.DESCRIPTION
Updates a Label by ID. The same applicability and uniqueness rules as creation apply.

.PARAMETER Id
ID of the Label to update.

.PARAMETER LabelTypeId
Updated Label Type ID.

.PARAMETER Labelable_Type
Updated target record type.

.PARAMETER Labelable_Id
Updated target record ID.

.EXAMPLE
Set-HuduLabel -Id 10 -Labelable_Type Asset -Labelable_Id 456

.EXAMPLE
Set-HuduLabel -Id 10 -LabelTypeId 2

.NOTES
API Endpoint: PUT /api/v1/labels/{id}
#>

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [Alias('LabelId','label_id')]
        [int]$Id,

        [Alias('label_type_id')]
        [int]$LabelTypeId,

        [ValidateScript({ Assert-AllowedObjectType -InputType $_ -AllowedCanonicals @(
            'Article', 'Asset', 'AssetPassword', 'Website', 'IpAddress', 'Vlan', 'VlanZone', 'Procedure', 'Network', 'RackStorage'
        ) })]
        [string]$Labelable_Type,

        [int]$Labelable_Id
    )

    $object = Get-HuduLabels -Id $Id
    if (-not $object) { return $null }

    if ($PSBoundParameters.ContainsKey('LabelTypeId')) {
        $object | Add-Member -MemberType NoteProperty -Name label_type_id -Force -Value $LabelTypeId
    }
    if ($PSBoundParameters.ContainsKey('Labelable_Type')) {
        $object | Add-Member -MemberType NoteProperty -Name labelable_type -Force -Value (Get-ObjectTypeFromCononical -inputData $Labelable_Type)
    }
    if ($PSBoundParameters.ContainsKey('Labelable_Id')) {
        $object | Add-Member -MemberType NoteProperty -Name labelable_id -Force -Value $Labelable_Id
    }

    $body = @{ label = $object } | ConvertTo-Json -Depth 99

    if ($PSCmdlet.ShouldProcess("Label Id=$Id", "Update")) {
        $resp = Invoke-HuduRequest -Method PUT -Resource "/api/v1/labels/$Id" -Body $body
        return ($resp.label ?? $resp)
    }
}
