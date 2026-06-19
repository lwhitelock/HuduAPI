function New-HuduLabel {
<#
.SYNOPSIS
Creates a Label on a Hudu record.

.DESCRIPTION
Creates a new Label record in Hudu by associating a Label Type with a specific
record. The Label Type must be applicable to the target record type.

.PARAMETER LabelTypeId
The ID of the Label Type to apply. Use Get-HuduLabelTypes to discover IDs.

.PARAMETER Labelable_Type
The type of object to attach the label to.

.PARAMETER Labelable_Id
The ID of the target object matching Labelable_Type.

.EXAMPLE
New-HuduLabel -LabelTypeId 5 -Labelable_Type Asset -Labelable_Id 123

.NOTES
API Endpoint: POST /api/v1/labels
#>

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [Alias('label_type_id','labeltype_id','label_typeid','label_type','type_id','typeid')]
        [int]$LabelTypeId,

        [Parameter(Mandatory)]
        [ValidateScript({ Assert-AllowedObjectType -InputType $_ -AllowedCanonicals @(
            'Article', 'Asset', 'AssetPassword', 'Website', 'IpAddress', 'Vlan', 'VlanZone', 'Procedure', 'Network', 'RackStorage'
        ) })]
        [Alias('object_type','objectType','target_type','targetType')]
        [string]$Labelable_Type,

        [Parameter(Mandatory)]
        [Alias('object_id','objectID','target_id','targetId')]
        [int]$Labelable_Id
    )

    $canonicalLabelableType = Get-ObjectTypeFromCononical -inputData $Labelable_Type
    $bodyObj = @{
        label = @{
            label_type_id  = $LabelTypeId
            labelable_type = $canonicalLabelableType
            labelable_id   = $Labelable_Id
        }
    }

    $body = $bodyObj | ConvertTo-Json -Depth 99

    if ($PSCmdlet.ShouldProcess("$canonicalLabelableType Id=$Labelable_Id", "Create Label (LabelTypeId=$LabelTypeId)")) {
        $resp = Invoke-HuduRequest -Method POST -Resource "/api/v1/labels" -Body $body
        return ($resp.label ?? $resp)
    }
}
