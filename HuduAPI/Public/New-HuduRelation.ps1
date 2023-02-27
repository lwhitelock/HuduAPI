function New-HuduRelation {
    <#
    .SYNOPSIS
    Create a Relation

    .DESCRIPTION
    Uses Hudu API to create relationships between objects

    .PARAMETER Description
    Give a description to the relation so you know why two things are related

    .PARAMETER FromableType
    The type of the FROM relation (Asset, Website, Procedure, AssetPassword, Company, Article)

    .PARAMETER FromableID
    The ID of the FROM relation

    .PARAMETER ToableType
    The type of the TO relation (Asset, Website, Procedure, AssetPassword, Company, Article)

    .PARAMETER ToableID
    The ID of the TO relation

    .PARAMETER IsInverse
    When a relation is created, it will also create another relation that is the inverse. When this is true, this relation is the inverse.

    .EXAMPLE
    An example

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [String]$Description,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Asset', 'Website', 'Procedure', 'AssetPassword', 'Company', 'Article')]
        [Alias('fromable_type')]
        [String]$FromableType,

        [Alias('fromable_id')]
        [int]$FromableID,

        [Alias('toable_type')]
        [String]$ToableType,

        [Alias('toable_id')]
        [int]$ToableID,

        [Alias('is_inverse')]
        [string]$IsInverse
    )

    $Relation = [ordered]@{relation = [ordered]@{} }

    $Relation.relation.add('fromable_type', $FromableType)
    $Relation.relation.add('fromable_id', $FromableID)
    $Relation.relation.add('toable_type', $ToableType)
    $Relation.relation.add('toable_id', $ToableID)

    if ($Description) {
        $Relation.relation.add('description', $Description)
    }

    if ($ISInverse) {
        $Relation.relation.add('is_inverse', $ISInverse)
    }

    $JSON = $Relation | ConvertTo-Json -Depth 100

    if ($PSCmdlet.ShouldProcess($FromableType)) {
        Invoke-HuduRequest -Method post -Resource '/api/v1/relations' -Body $JSON
    }
}