function Set-HuduFlag {
    <#
    .SYNOPSIS
    Update a flag

    .DESCRIPTION
    Uses Hudu API to update a Flag. If updating the flagable association,
    flagable_type must be valid and the record must exist.

    .PARAMETER Id
    ID of the flag to update

    .PARAMETER FlagTypeId
    Updated flag type ID

    .PARAMETER Description
    Updated description

    .PARAMETER flagable_type
    Updated flagable type (Asset, Website, Article, AssetPassword, Company, Procedure, RackStorage, Network, IpAddress, Vlan, VlanZone)

    .PARAMETER flagable_id
    Updated flagable record ID

    .EXAMPLE
    Set-HuduFlag -Id 10 -Description "Updated flag description" -FlagTypeId 2

    .EXAMPLE
    Set-HuduFlag -Id 10 -flagable_type Asset -flagable_id 123
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory = $true)]
        [Alias('FlagId','flag_id')]
        [int]$Id,

        [Alias('flag_type_id',"flagType_Id")]
        [int]$FlagTypeId,

        [string]$Description = '',

        [Alias('flaggabletype','flaggable_type','flagabletype','Flag_type','FlagType')]
        [ValidateSet('asset', 'assets', 'anlage', 'objekt', 'actif', 'bene', 'activo', 'website', 'webseite', 'site', 'sito', 'sitio', 'article', 'articles', 'kb', 'knowledgebase', 'artikel', 'articolo', 'artículo', 'assetpassword', 'asset_password', 'password', 'passwort', 'motdepasse', 'contraseña', 'company', 'companies', 'firma', 'entreprise', 'azienda', 'empresa', 'procedure', 'process', 'verfahren', 'procédure', 'procedura', 'procedimiento', 'rackstorage', 'rack_storage', 'rack', 'rackstorages', 'armoire', 'network', 'netzwerk', 'réseau', 'rete', 'red', 'ipaddress', 'ip_address', 'ip', 'ipadresse', 'adresseip', 'indirizzoip', 'direccionip', 'vlan', 'vlans', 'vlanzone', 'vlan_zone', 'zone', 'zonevlan',IgnoreCase = $true)]
        [string]$Flagable_Type,

        [Alias("FlaggableId","flaggable_id","flagableid")]
        [int]$flagable_id
    )

    $Object = Get-HuduFlags -Id $Id
    if (-not $Object) { return $null }

    $Flag = [ordered]@{ flag = $Object }

    if ($PSBoundParameters.ContainsKey('FlagTypeId')) {
        $Flag.flag.flag_type_id = $FlagTypeId
    }

    if ($Description) {
        $Flag.flag.description = $Description
    }

    if ($flagable_type) {
        $Flag.flag.flagable_type = $(Set-FlagableFromCanonical -inputData $flagable_type)
    }

    if ($PSBoundParameters.ContainsKey('flagable_id')) {
        $Flag.flag.flagable_id = $flagable_id
    }

    $JSON = $Flag | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method PUT -Resource "/api/v1/flags/$Id" -Body $JSON
    }
}