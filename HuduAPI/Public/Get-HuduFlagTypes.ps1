
function Get-HuduFlagTypes {
<#
.SYNOPSIS
Gets Flag Types from Hudu.

.DESCRIPTION
Retrieves Flag Types by ID or lists Flag Types with optional filtering. When listing,
filters match exact values for name/color/slug when provided. Results are paginated.

.PARAMETER Id
Return a single Flag Type by ID.

.PARAMETER Name
Filter by exact Flag Type name.

.PARAMETER Color
Filter by exact color value (canonicalized to Hudu).

.PARAMETER Slug
Filter by exact slug value.

.EXAMPLE
Get-HuduFlagTypes
# List all flag types

.EXAMPLE
Get-HuduFlagTypes -Name "Security Risk"
# Find the "Security Risk" flag type

.EXAMPLE
Get-HuduFlagTypes -Id 12
# Get a specific flag type by ID

.NOTES
API Endpoints:
- GET /api/v1/flag_types
- GET /api/v1/flag_types/{id}
#>

    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById')]
        [Alias('FlagTypeId','flag_type_id')]
        [int]$Id,

        [Parameter(ParameterSetName = 'List')]
        [string]$Name,

        [Parameter()]
        [ValidateSet('red', 'crimson', 'scarlet', 'rot', 'karminrot', 'scharlachrot', 'rouge', 'cramoisi', 'écarlate', 'rosso', 'cremisi', 'scarlatto', 'rojo', 'carmesí', 'escarlata', 'blue', 'navy', 'blau', 'marineblau', 'bleu', 'bleu marine', 'blu', 'blu navy', 'azul', 'azul marino', 'green', 'lime', 'grün', 'limettengrün', 'vert', 'vert citron', 'verde', 'verde lime', 'verde lima', 'yellow', 'gold', 'gelb', 'jaune', 'or', 'giallo', 'oro', 'amarillo', 'purple', 'violet', 'lila', 'violett', 'pourpre', 'viola', 'porpora', 'púrpura', 'violeta', 'orange', 'arancione', 'naranja', 'light pink', 'pink', 'baby pink', 'hellrosa', 'rosa', 'rose clair', 'rose', 'rosa chiaro', 'rosa claro', 'light blue', 'baby blue', 'sky blue', 'hellblau', 'babyblau', 'himmelblau', 'bleu clair', 'bleu ciel', 'azzurro', 'blu chiaro', 'azul claro', 'celeste', 'light green', 'mint', 'hellgrün', 'mintgrün', 'vert clair', 'menthe', 'verde chiaro', 'menta', 'verde claro', 'light purple', 'lavender', 'helllila', 'lavendel', 'violet clair', 'lavande', 'viola chiaro', 'lavanda', 'morado claro', 'light orange', 'peach', 'hellorange', 'pfirsich', 'orange clair', 'pêche', 'arancione chiaro', 'pesca', 'naranja claro', 'melocotón', 'light yellow', 'cream', 'hellgelb', 'creme', 'jaune clair', 'crème', 'giallo chiaro', 'crema', 'amarillo claro', 'white', 'weiß', 'blanc', 'bianco', 'blanco', 'grey', 'gray', 'silver', 'grau', 'silber', 'gris', 'argent', 'grigio', 'argento', 'plateado', 'lightpink', 'lightblue', 'lightgreen', 'lightpurple', 'lightorange', 'lightyellow',IgnoreCase = $true)]
        [string]$Color,

        [string]$Slug
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            $resp = Invoke-HuduRequest -Method GET -Resource "/api/v1/flag_types/$Id"
            return ($resp.flag_type ?? $resp)
        }

        $params = @{}
        if ($PSBoundParameters.ContainsKey('Name'))      { $params.name       = $Name }
        if ($PSBoundParameters.ContainsKey('Color'))     { 
            $params.color      = $(Set-ColorFromCanonical -inputData $Color) 
        }
        if ($PSBoundParameters.ContainsKey('Slug'))      { $params.slug       = $Slug }
        $params.page = 1
        $params.page_size = 1000
        $req = @{
            Method   = 'GET'
            Resource = "/api/v1/flag_types"
            Params   = $params
        }

        Invoke-HuduRequestPaginated -HuduRequest $req -Property 'flag_types'
    }
}
