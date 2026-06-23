function ConvertTo-HuduLabelColor {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Color
    )

    $normalizedColor = $Color.Trim()

    if ($normalizedColor -match '^#?[0-9a-fA-F]{6}([0-9a-fA-F]{2})?$') {
        $hexColor = $normalizedColor.TrimStart('#')
        return "#$($hexColor.Substring(0, 6))"
    }

    $canonicalColor = Set-ColorFromCanonical -inputData $normalizedColor
    $canonicalColorHex = @{
        Red         = '#ff0000'
        Blue        = '#0000ff'
        Green       = '#008000'
        Yellow      = '#ffff00'
        Purple      = '#800080'
        Orange      = '#ffa500'
        LightPink   = '#ffb6c1'
        LightBlue   = '#add8e6'
        LightGreen  = '#90ee90'
        LightPurple = '#cbc3e3'
        LightOrange = '#ffcc99'
        LightYellow = '#ffffe0'
        White       = '#ffffff'
        Grey        = '#808080'
    }

    if ($canonicalColorHex.ContainsKey($canonicalColor)) {
        return $canonicalColorHex[$canonicalColor]
    }

    throw "Invalid label color '$Color'. Unable to convert canonical color '$canonicalColor' to a hexadecimal color."
}
