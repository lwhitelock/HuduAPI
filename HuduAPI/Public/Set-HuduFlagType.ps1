function Set-HuduFlagType {
    <#
    .SYNOPSIS
    Update a flag type

    .DESCRIPTION
    Uses Hudu API to update a Flag Type

    .PARAMETER Id
    ID of the flag type to update

    .PARAMETER Name
    Updated name

    .PARAMETER Color
    Human friendly color name. Valid colors are: Red, Blue, Green, Yellow, Purple, Orange, LightPink, LightBlue, LightGreen, LightPurple, LightOrange, LightYellow, White, Grey

    .EXAMPLE
    Set-HuduFlagType -Id 1 -Name "Updated Flag Type" -Color "Green"
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory = $true)]
        [int]$Id,

        [string]$Name = '',

        [Parameter()]
        [ValidateSet('red', 'crimson', 'scarlet', 'rot', 'karminrot', 'scharlachrot', 'rouge', 'cramoisi', 'écarlate', 'rosso', 'cremisi', 'scarlatto', 'rojo', 'carmesí', 'escarlata', 'blue', 'navy', 'blau', 'marineblau', 'bleu', 'bleu marine', 'blu', 'blu navy', 'azul', 'azul marino', 'green', 'lime', 'grün', 'limettengrün', 'vert', 'vert citron', 'verde', 'verde lime', 'verde lima', 'yellow', 'gold', 'gelb', 'jaune', 'or', 'giallo', 'oro', 'amarillo', 'purple', 'violet', 'lila', 'violett', 'pourpre', 'viola', 'porpora', 'púrpura', 'violeta', 'orange', 'arancione', 'naranja', 'light pink', 'pink', 'baby pink', 'hellrosa', 'rosa', 'rose clair', 'rose', 'rosa chiaro', 'rosa claro', 'light blue', 'baby blue', 'sky blue', 'hellblau', 'babyblau', 'himmelblau', 'bleu clair', 'bleu ciel', 'azzurro', 'blu chiaro', 'azul claro', 'celeste', 'light green', 'mint', 'hellgrün', 'mintgrün', 'vert clair', 'menthe', 'verde chiaro', 'menta', 'verde claro', 'light purple', 'lavender', 'helllila', 'lavendel', 'violet clair', 'lavande', 'viola chiaro', 'lavanda', 'morado claro', 'light orange', 'peach', 'hellorange', 'pfirsich', 'orange clair', 'pêche', 'arancione chiaro', 'pesca', 'naranja claro', 'melocotón', 'light yellow', 'cream', 'hellgelb', 'creme', 'jaune clair', 'crème', 'giallo chiaro', 'crema', 'amarillo claro', 'white', 'weiß', 'blanc', 'bianco', 'blanco', 'grey', 'gray', 'silver', 'grau', 'silber', 'gris', 'argent', 'grigio', 'argento', 'plateado', 'lightpink', 'lightblue', 'lightgreen', 'lightpurple', 'lightorange', 'lightyellow',IgnoreCase = $true)]
        [string]$Color
    )

    $Object = Get-HuduFlagTypes -Id $Id
    if (-not $Object) { return $null }

    $FlagType = [ordered]@{ flag_type = $Object }
    if ($Name)  { $FlagType.flag_type.name  = $Name }
    if ($Color) { $FlagType.flag_type.color = $(Set-ColorFromCanonical -inputData $Color) }

    $JSON = $FlagType | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Id)) {
        $result = Invoke-HuduRequest -Method PUT -Resource "/api/v1/flag_types/$Id" -Body $JSON
        return ($result.flag_type ?? $result)
    }
}
