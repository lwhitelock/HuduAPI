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

    Set-ColorFromCanonical -inputData $normalizedColor
}
