function Get-HuduFlags {
<#
.SYNOPSIS
Gets Flags from Hudu.

.DESCRIPTION
Retrieves a single Flag by ID, or lists Flags with optional filtering by flag type,
target object type/id, and description. Results are paginated when listing.

.PARAMETER Id
Return a single Flag by ID.

.PARAMETER FlagTypeId
Filter flags by Flag Type ID.

.PARAMETER flagable_type
Filter by the target object type the flag is attached to (e.g., Company, Asset).
This value is normalized to Hudu's canonical flagable_type.

.PARAMETER flagable_id
Filter by the target object ID the flag is attached to.

.PARAMETER Description
Filter by description text (exact match behavior depends on API; treat as an exact filter unless documented otherwise).

.EXAMPLE
Get-HuduFlags
# List all flags (paginated)

.EXAMPLE
Get-HuduFlags -FlagTypeId 5
# List all flags using flag type 5

.EXAMPLE
Get-HuduFlags -flagable_type Company -flagable_id 123
# List all flags attached to company 123

.EXAMPLE
Get-HuduFlags -Id 77
# Get a single flag by ID

.NOTES
API Endpoints:
- GET /api/v1/flags
- GET /api/v1/flags/{id}
#>

    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById')]
        [Alias('FlagId','flag_id')]
        [int]$Id,

        [Parameter(ParameterSetName = 'List')]
        [Alias("Flag_Type_ID","FlagType_ID","Flag_TypeId")]
        [int]$FlagTypeId,

        [Parameter(ParameterSetName = 'List')]
        [Alias('flagabletype',"flaggable_type","flaggabletype","Flag_type","FlagType")]
        [ValidateSet('asset', 'assets', 'anlage', 'objekt', 'actif', 'bene', 'activo', 'website', 'webseite', 'site', 'sito', 'sitio', 'article', 'articles', 'kb', 'knowledgebase', 'artikel', 'articolo', 'artículo', 'assetpassword', 'asset_password', 'password', 'passwort', 'motdepasse', 'contraseña', 'company', 'companies', 'firma', 'entreprise', 'azienda', 'empresa', 'procedure', 'process', 'verfahren', 'procédure', 'procedura', 'procedimiento', 'rackstorage', 'rack_storage', 'rack', 'rackstorages', 'armoire', 'network', 'netzwerk', 'réseau', 'rete', 'red', 'ipaddress', 'ip_address', 'ip', 'ipadresse', 'adresseip', 'indirizzoip', 'direccionip', 'vlan', 'vlans', 'vlanzone', 'vlan_zone', 'zone', 'zonevlan',IgnoreCase = $true)]
        [string]$flagable_type,

        [Parameter(ParameterSetName = 'List')]
        [Alias("FlaggableId","flaggable_id","flagableid")]
        [int]$flagable_id,

        [string]$Description
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            $resp = Invoke-HuduRequest -Method GET -Resource "/api/v1/flags/$Id"
            return ($resp.flag ?? $resp ?? $null)
        }

        $params = @{}
        if ($PSBoundParameters.ContainsKey('FlagTypeId'))   { $params.flag_type_id  = $FlagTypeId }
        if ($PSBoundParameters.ContainsKey('flagable_type')) {
            $params.flagable_type = $(Set-FlagableFromCanonical -inputData $flagable_type)
        }
        if ($PSBoundParameters.ContainsKey('flagable_id'))   { $params.flagable_id   = $flagable_id }
        if ($PSBoundParameters.ContainsKey('Description'))  { $params.description   = $Description }
        $req = @{
            Method   = 'GET'
            Resource = "/api/v1/flags"
            Params   = $params
        }

        $resp = Invoke-HuduRequestPaginated -HuduRequest $req -Property 'flags'
        return ($resp.flags ?? $resp ?? $null)
    }
}
