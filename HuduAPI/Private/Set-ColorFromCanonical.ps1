
Function Set-ColorFromCanonical {
    param (
        [string] $inputData
    ) 
    if ([string]::IsNullOrWhiteSpace($inputData)) { return $null }
    if (-not $(get-variable -name 'script:ColorLookup' -scope 'script' -erroraction silentlycontinue)) {
        $script:ColorMap = [ordered]@{ # English, German, French, Italian, Spanish, Portuguese, Dutch, Polish
            Red = @('red','crimson','scarlet','rot','karminrot','scharlachrot','rouge','rouges','cramoisi','cramoisie','écarlate','ecarlate','rosso','rossa','rossi','rosse','cremisi','scarlatto','scarlatta','rojo','roja','rojos','rojas','carmesí','carmesi','escarlata','vermelho','vermelha','vermelhos','vermelhas','carmesim','escarlate','rood','rode','karmozijn','scharlaken','czerwony','czerwona','czerwone','karmazynowy')
            Blue = @('blue','navy','blau','marineblau','bleu','bleue','bleus','bleues','bleu_marine','blu','blu_navy','azul','azules','azul_marino','azuis','azul_marinho','blauw','blauwe','marineblauw','niebieski','niebieska','niebieskie','granatowy')
            Green = @('green','lime','grün','gruen','limettengrün','limettengruen','vert','verte','verts','vertes','vert_citron','verde','verdi','verde_lime','verdes','verde_lima','groen','groene','limoengroen','zielony','zielona','zielone','limonkowy')
            Yellow = @('yellow','gold','gelb','golden','jaune','or','doré','dore','giallo','gialla','gialli','gialle','oro','dorato','amarillo','amarilla','amarillos','amarillas','dorado','dorada','amarelo','amarela','amarelos','amarelas','ouro','dourado','dourada','geel','gele','goud','gouden','żółty','zolty','żółta','zolta','żółte','zolte','złoty','zloty')
            Purple = @('purple','violet','lila','violett','violette','pourpre','viola','porpora','púrpura','purpura','violeta','morado','morada','roxo','roxa','roxos','roxas','paars','paarse','fioletowy','fioletowa','fioletowe','purpurowy')
            Orange = @('orange','arancione','naranja','anaranjado','anaranjada','laranja','alaranjado','alaranjada','oranje','pomarańczowy','pomaranczowy','pomarańczowa','pomaranczowa')
            LightPink = @('light_pink','pink','baby_pink','hellrosa','rosa','babyrosa','rose_clair','rose','rose_pâle','rose_pale','rosa_chiaro','rosa_claro','rosa_clara','rosado','rosada','lichtroze','roze','babyroze','jasnoróżowy','jasnorozowy','różowy','rozowy')
            LightBlue = @('light_blue','baby_blue','sky_blue','hellblau','babyblau','himmelblau','bleu_clair','bleu_ciel','bleu_pâle','bleu_pale','azzurro','azzurra','azzurri','azzurre','blu_chiaro','azul_claro','azul_celeste','celeste','lichtblauw','hemelsblauw','babyblauw','jasnoniebieski','błękitny','blekitny')
            LightGreen = @('light_green','mint','mint_green','hellgrün','hellgruen','mintgrün','mintgruen','vert_clair','menthe','vert_menthe','verde_chiaro','menta','verde_menta','verde_claro','lichtgroen','muntgroen','jasnozielony','miętowy','mietowy')
            LightPurple = @('light_purple','lavender','lilac','helllila','lavendel','violet_clair','lavande','lilas','viola_chiaro','lavanda','lilla','morado_claro','morada_clara','lila','roxo_claro','roxa_clara','lilás','lichtpaars','jasnofioletowy','lawendowy')
            LightOrange = @('light_orange','peach','hellorange','pfirsich','orange_clair','pêche','peche','arancione_chiaro','pesca','naranja_claro','naranja_clara','melocotón','melocoton','durazno','laranja_claro','laranja_clara','pêssego','pessego','lichtoranje','perzik','jasnopomarańczowy','jasnopomaranczowy','brzoskwiniowy')
            LightYellow = @('light_yellow','cream','hellgelb','creme','cremefarben','jaune_clair','crème','giallo_chiaro','crema','amarillo_claro','amarilla_clara','amarelo_claro','amarela_clara','lichtgeel','jasnożółty','jasnozolty','kremowy')
            White = @('white','weiß','weiss','blanc','blanche','blancs','blanches','bianco','bianca','bianchi','bianche','blanco','blanca','blancos','blancas','branco','branca','brancos','brancas','wit','witte','biały','bialy','biała','biala','białe','biale')
            Grey = @('grey','gray','silver','grau','silber','gris','grise','argent','argenté','argente','grigio','grigia','grigi','grigie','argento','grises','plateado','plateada','plata','cinza','cinzento','cinzenta','prata','prateado','prateada','grijs','grijze','zilver','szary','szara','szare','srebrny','srebrna')
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