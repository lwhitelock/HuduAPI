$Public = @( Get-ChildItem -Recurse -Path "$PSScriptRoot\Public\" -File -Filter *.ps1 )
$Private = @( Get-ChildItem -Recurse -Path "$PSScriptRoot\Private\" -File -Filter *.ps1 )
@($Public + $Private) | ForEach-Object {
    Try {
        If ($_.Length -gt 0) {. $_.FullName}
    } Catch {
        Write-Error -Message "Failed to import function $($_.FullName): $_"
    }
}
Export-ModuleMember -Function $Public.BaseName -Alias *