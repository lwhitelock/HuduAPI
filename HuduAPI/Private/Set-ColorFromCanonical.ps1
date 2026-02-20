
Function Set-ColorFromCanonical {
    param (
        [string] $inputData
    ) 
    if ([string]::IsNullOrWhiteSpace($inputData)) { return $null }
    if (-not $(get-variable -name 'script:ColorLookup' -scope 'script' -erroraction silentlycontinue)) {
        $script:ColorMap = [ordered]@{ # German, French, Italian, Spanish
            Red = @('red','crimson','scarlet', 'rot','karminrot','scharlachrot','rouge','cramoisi','écarlate', 'rosso','cremisi','scarlatto', 'rojo','carmesí','escarlata')
            Blue = @('blue','navy', 'blau','marineblau', 'bleu','bleu marine', 'blu','blu navy', 'azul','azul marino')
            Green = @('green','lime', 'grün','limettengrün', 'vert','vert citron', 'verde','verde lime', 'verde','verde lima')
            Yellow = @('yellow','gold', 'gelb','gold', 'jaune','or', 'giallo','oro', 'amarillo','oro')
            Purple = @('purple','violet', 'lila','violett', 'violet','pourpre', 'viola','porpora', 'púrpura','violeta')
            Orange = @('orange', 'orange', 'orange', 'arancione', 'naranja')
            LightPink = @('light pink','pink','baby pink', 'hellrosa','rosa', 'rose clair','rose', 'rosa chiaro','rosa', 'rosa claro','rosa')
            LightBlue = @('light blue','baby blue','sky blue', 'hellblau','babyblau','himmelblau', 'bleu clair','bleu ciel', 'azzurro','blu chiaro', 'azul claro','celeste')
            LightGreen = @('light green','mint', 'hellgrün','mintgrün', 'vert clair','menthe', 'verde chiaro','menta', 'verde claro','menta')
            LightPurple = @('light purple','lavender', 'helllila','lavendel', 'violet clair','lavande', 'viola chiaro','lavanda', 'morado claro','lavanda')
            LightOrange = @('light orange','peach', 'hellorange','pfirsich', 'orange clair','pêche', 'arancione chiaro','pesca', 'naranja claro','melocotón')
            LightYellow = @('light yellow','cream', 'hellgelb','creme', 'jaune clair','crème', 'giallo chiaro','crema', 'amarillo claro','crema')
            White = @('white', 'weiß', 'blanc', 'bianco', 'blanco')
            Grey = @('grey','gray','silver', 'grau','silber', 'gris','argent', 'grigio','argento', 'gris','plateado')
        }

        
    $script:ColorLookup = @{}
    foreach ($canonical in $script:ColorMap.Keys) {
        $all = @($canonical) + $script:ColorMap[$canonical]
        foreach ($v in $all) {
            if (-not $v) { continue }

            $k = $v.ToLowerInvariant()
            $k = $k -replace '[-\s]+','_'    # normalize separators
            $script:ColorLookup[$k] = $canonical
        }
    }        
    }

    $raw = ([string]$inputData).Trim()
    if ($raw.Length -eq 0) { return $raw }

    $key = $raw.ToLowerInvariant() -replace '[-\s]+','_'

    if ($script:ColorLookup.ContainsKey($key)) {
        return $script:ColorLookup[$key]
    }

    $allowed = ($script:ColorMap.Keys -join ', ')
    throw "Invalid color '$raw'. Allowed values: $allowed"
}