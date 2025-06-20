function Convert-ToHuduDateRange {
    param(
        [Parameter(Position = 0)][Nullable[datetime]]$Start,
        [Parameter(Position = 1)][Nullable[datetime]]$End
    )

    $startStr = if ($Start) { $Start.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") } else { '' }
    $endStr = if ($End) { $End.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") } else { '' }

    return $(if (("$startStr,$endStr") -eq ",") {$null} else {"$startStr,$endStr"})
}
