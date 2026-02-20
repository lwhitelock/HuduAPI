function Set-FlagableFromCanonical {
    param ([string]$inputData)
    if ([string]::IsNullOrWhiteSpace($inputData)) { return $null }

        if (-not $(get-variable -name 'script:FlaggableTypeLookup' -scope 'script' -erroraction silentlycontinue)) {
            $script:FlaggableTypeMap = [ordered]@{ # German, French, Italian, Spanish
                Asset         = @('asset','assets', 'anlage','objekt', 'actif', 'bene', 'activo')
                Website       = @('website', 'webseite', 'site', 'sito', 'sitio')
                Article       = @('article','articles','kb','knowledgebase', 'artikel', 'article', 'articolo', 'artículo')
                AssetPassword = @('assetpassword','asset_password','password', 'passwort', 'motdepasse', 'password', 'contraseña')
                Company       = @('company','companies', 'firma', 'entreprise', 'azienda', 'empresa')
                Procedure     = @('procedure','process', 'verfahren', 'procédure', 'procedura', 'procedimiento')
                RackStorage   = @('rackstorage','rack_storage','rack','rackstorages', 'rack', 'armoire')
                Network       = @('network', 'netzwerk', 'réseau', 'rete', 'red')
                IpAddress     = @('ipaddress','ip_address','ip', 'ipadresse', 'adresseip', 'indirizzoip', 'direccionip')
                Vlan          = @('vlan','vlans', 'vlan')
                VlanZone      = @('vlanzone','vlan_zone','zone', 'zonevlan')
            }
            $script:FlaggableTypeLookup = @{}
            foreach ($canonical in $script:FlaggableTypeMap.Keys) {
                # include canonical itself as accepted input
                $all = @($canonical) + $script:FlaggableTypeMap[$canonical]

                foreach ($v in $all) {
                    if ([string]::IsNullOrWhiteSpace($v)) { continue }
                    $k = ($v -as [string]).Trim().ToLowerInvariant()
                    $k = $k -replace '[-\s]+','_'      # treat dashes/spaces like underscores
                    $script:FlaggableTypeLookup[$k] = $canonical
                }
            }            
        }               

        $raw = ([string]$inputData).Trim()
        if ($raw.Length -eq 0) { return $raw }

        $k = $raw.ToLowerInvariant() -replace '[-\s]+','_'

        $lookup = $script:FlaggableTypeLookup
        if ($lookup.ContainsKey($k)) {
            return $lookup[$k]
        }
        $allowed = ($script:FlaggableTypeMap.Keys -join ', ')
        throw "Invalid flaggable type '$raw'. Allowed: $allowed"
}
