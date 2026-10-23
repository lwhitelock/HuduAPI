function Set-HuduAssetLayoutNumberField {
    param (
        [Parameter(Mandatory)]
        [hashtable]$Field
    )

    $NumberType = ([string]$Field.number_type).Trim().ToLowerInvariant()
    if ([string]::IsNullOrWhiteSpace($NumberType)) {
        if ([string]::IsNullOrWhiteSpace($Field.currency_code)) {
            $Field.Remove('number_type')
            $Field.Remove('currency_code')
            return
        }
        $NumberType = 'currency'
    }

    switch ($NumberType) {
        'currency' {
            $Field.number_type = 'currency'
            $Field.currency_code = Assert-CurrencyISO4217 -CurrencyCode $Field.currency_code
        }
        { $_ -in @('number', 'percent', 'percentage') } {
            $Field.number_type = if ($NumberType -eq 'number') { 'number' } else { 'percentage' }
            $Field.Remove('currency_code')
        }
        default {
            throw "Invalid number_type '$($Field.number_type)' for field '$($Field.label)'. Use number, currency, or percentage (alias: percent)."
        }
    }
}
