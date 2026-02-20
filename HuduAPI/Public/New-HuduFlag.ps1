function New-HuduFlag {
<#
.SYNOPSIS
Creates a Flag on a Hudu object (asset, website, article, etc.).

.DESCRIPTION
Creates a new Flag record in Hudu by associating a Flag Type with a specific object
(e.g., a Company, Asset, Network, VLAN). Use FlagTypeId to choose the flag style/color,
and Flagable_Type + Flagable_Id to point at the target object.

.PARAMETER FlagTypeId
The ID of the Flag Type to apply. Use Get-HuduFlagTypes to discover IDs.

.PARAMETER Description
Optional note shown on the flag. Useful for context like "Needs review" or "Decommission pending".

.PARAMETER Flagable_Type
The type of object to attach the flag to (e.g., Company, Asset, Website, Network).
This value is normalized to Hudu's canonical flagable_type before the request is sent.

.PARAMETER flagable_id
The ID of the target object (matching Flagable_Type). For example, a Company ID if Flagable_Type is Company.

.EXAMPLE
# Flag company 123 with flag type 5
New-HuduFlag -FlagTypeId 5 -Flagable_Type Company -flagable_id 123 -Description "Contract renewal due"

.EXAMPLE
# Flag asset 88 with flag type 2
New-HuduFlag -FlagTypeId 2 -Flagable_Type Asset -flagable_id 88

.NOTES
API Endpoint: POST /api/v1/flags
Requires Hudu API access configured for Invoke-HuduRequest.
#>    
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [int]$FlagTypeId,

        [Parameter()]
        [string]$Description,
    
        [Parameter(Mandatory)]
        [Alias('flaggabletype','flaggable_type','flagabletype','Flag_type','FlagType')]
        [ValidateSet('asset', 'assets', 'anlage', 'objekt', 'actif', 'bene', 'activo', 'website', 'webseite', 'site', 'sito', 'sitio', 'article', 'articles', 'kb', 'knowledgebase', 'artikel', 'articolo', 'artículo', 'assetpassword', 'asset_password', 'password', 'passwort', 'motdepasse', 'contraseña', 'company', 'companies', 'firma', 'entreprise', 'azienda', 'empresa', 'procedure', 'process', 'verfahren', 'procédure', 'procedura', 'procedimiento', 'rackstorage', 'rack_storage', 'rack', 'rackstorages', 'armoire', 'network', 'netzwerk', 'réseau', 'rete', 'red', 'ipaddress', 'ip_address', 'ip', 'ipadresse', 'adresseip', 'indirizzoip', 'direccionip', 'vlan', 'vlans', 'vlanzone', 'vlan_zone', 'zone', 'zonevlan',IgnoreCase = $true)]
        [string]$Flagable_Type,

        [Parameter(Mandatory)]
        [Alias("FlaggableId","flaggable_id","flagableid")]
        [int]$flagable_id
    )

    $bodyObj = @{
        flag = @{
            flag_type_id  = $FlagTypeId
            description   = $Description
            flagable_type = $(Set-FlagableFromCanonical -inputData $Flagable_Type)
            flagable_id   = $flagable_id
        }
    }

    $body = $bodyObj | ConvertTo-Json -Depth 99

    if ($PSCmdlet.ShouldProcess("$flagable_type Id=$flagable_id", "Create Flag (FlagTypeId=$FlagTypeId)")) {
        $resp = Invoke-HuduRequest -Method POST -Resource "/api/v1/flags" -Body $body
        return ($resp.flag ?? $resp)
    }
}
