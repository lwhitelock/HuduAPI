function Get-HuduAssetLayoutFieldID {
    <#
    .SYNOPSIS
    Get Hudu Asset Layout Field ID

    .DESCRIPTION
    Retrieves ID for Hudu Asset Layout Fields

    .PARAMETER Name
    Name of Field

    .PARAMETER LayoutId
    Asset Layout Id

    .EXAMPLE
    Get-HuduAssetLayoutFieldID -Name 'Extra Info' -LayoutId 1

    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [Alias('asset_layout_id')]
        [Parameter(Mandatory = $true)]
        [Int]$LayoutId
    )

    $Layout = Get-HuduAssetLayouts -LayoutId $LayoutId

    $Fields = [Collections.Generic.List[Object]]($Layout.fields)
    $Index = $Fields.FindIndex( { $args[0].label -eq $Name } )
    $Fields[$Index].id
}
