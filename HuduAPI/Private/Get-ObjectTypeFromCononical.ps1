function Get-ObjectTypeFromCononical {
    param ([string]$inputData)
    if ([string]::IsNullOrWhiteSpace($inputData)) { return $null }

        if (-not $(get-variable -name 'script:ObjectTypeLookup' -scope 'script' -erroraction silentlycontinue)) {
            $script:ObjectTypeMap = [ordered]@{ # German, French, Italian, Spanish
                Article       = @('article','articles','kb','knowledgebase', 'artikel', 'article', 'articolo', 'artículo')
                Asset         = @('asset','assets', 'anlage','objekt', 'actif', 'bene', 'activo')
                AssetPassword = @('assetpassword','asset_password','password', 'passwort', 'motdepasse', 'passwords', 'contraseña')
                Company       = @('company','companies', 'firma', 'entreprise', 'azienda', 'empresa')
                IpAddress     = @('ipaddress', 'ipaddresses','ip_address','ip', 'ipadresse', 'adresseip', 'indirizzoip', 'direccionip')
                Network       = @('network', 'networks', 'netzwerk', 'réseau', 'rete', 'red')
                Photo         = @('photo', 'photos', 'foto', 'fotos', 'photograph', 'photographie', 'fotografía')
                PublicPhoto   = @('publicphoto', 'public_photo', 'publicfoto', 'publicphotograph', 'publicphotographie', 'publicfotografía')
                Procedure     = @('procedure', 'procedures', 'process', 'verfahren', 'procédure', 'procedura', 'procedimiento')
                RackStorage   = @('rackstorage','rack_storage','rack','rackstorages', 'rack', 'armoire')
                Vlan          = @('vlan','vlans', 'vlan')
                VlanZone      = @('vlanzone','vlan_zone','zone', 'zonevlan', 'zonen', 'zonevlan','zone_vlan','zone','zones', 'zonalan','zona_vlan','zona','zonas')
                Website       = @('website', 'webseite', 'site', 'sito','siti','sito_web','sitio', 'webseiten','internetseite','internetseiten','sitios','pagina_web','página_web' )
            }
            $script:ObjectTypeLookup = @{}
            foreach ($canonical in $script:ObjectTypeMap.Keys) {
                # include canonical itself as accepted input
                $all = @($canonical) + $script:ObjectTypeMap[$canonical]

                foreach ($v in $all) {
                    if ([string]::IsNullOrWhiteSpace($v)) { continue }
                    $k = ($v -as [string]).Trim().ToLowerInvariant()
                    $k = $k -replace '[-\s]+','_'      # treat dashes/spaces like underscores
                    $script:ObjectTypeLookup[$k] = $canonical
                }
            }            
        }               

        $raw = ([string]$inputData).Trim()
        if ($raw.Length -eq 0) { return $raw }

        $k = $raw.ToLowerInvariant() -replace '[-\s]+','_'

        $lookup = $script:ObjectTypeLookup
        if ($lookup.ContainsKey($k)) {
            return $lookup[$k]
        }
        $allowed = ($script:ObjectTypeMap.Keys -join ', ')
        throw "Invalid flaggable type '$raw'. Allowed: $allowed"
}

