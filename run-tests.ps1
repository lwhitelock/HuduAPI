#!/usr/bin/env pwsh
# Run-HuduTests.ps1

param (
    [string]$EnvironFile,
    [string]$FilterTests=$null
)

$testsPath = Join-Path $PSScriptRoot "HuduAPI" "tests"
$modulePath = Join-Path $PSScriptRoot "HuduAPI" 'Huduapi.psd1'
$envFile = Join-Path $testsPath $EnvironFile
if (-not $envFile -or -not (Test-Path $envFile)) {
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($EnvironFile)
    $envFile = Get-ChildItem -Recurse -Path $(resolve-path .) -Filter "*$baseName*.ps1" | Select-Object -First 1 | ForEach-Object { $_.FullName }
}


Write-Host "Starting tests in: $testsPath"
Write-Host "Using module: $modulePath"
Write-Host "Env file: $envFile"

# Ensure Pester 5+
$requiredVersion = "5.0.0"
if (-not (Get-Module -ListAvailable Pester | Where-Object { $_.Version -ge $requiredVersion })) {
    Write-Host "Installing Pester $requiredVersion+..." -ForegroundColor Yellow
    Install-Module Pester -Scope CurrentUser -Force -SkipPublisherCheck
}

Remove-Module Pester -ErrorAction SilentlyContinue
Import-Module Pester -MinimumVersion $requiredVersion -Force

Remove-Module Huduapi -ErrorAction SilentlyContinue
Import-Module $modulePath -Force

# Load env
if (Test-Path $envFile) {
    Write-Host "Sourcing environment from $envFile" -ForegroundColor Cyan
    . "$envFile"
}

# Validate env vars
$requiredVars = @(
"HUDU_TEST_RACK_ROLE_ID",
"HUDU_TEST_RACK_STORAGE_ID",
"HUDU_TEST_COMPANY_ID",
"HUDU_TEST_PROCEDURE_ID",
"HUDU_TEST_ASSET_ID",
"HUDU_TEST_ARTICLE_ID",
"HUDU_TEST_USER_ID",
"HUDU_TEST_VLAN_ID",
"HUDU_TEST_IPAM_STATUS_ROLE_ID",
"HUDU_TEST_IPAM_LIST_ITEM_ID",
"HUDU_TEST_NETWORK_ID",
"HUDU_TEST_VLAN_ZONE_ID",
"HUDU_TEST_IP_ADDRESS_ID",
"HUDU_TEST_WEBSITE_ID",
"HUDU_TEST_PASSWORD_ID"
)
foreach ($var in $requiredVars) {
    if (-not (Get-Item "env:$var" -ErrorAction SilentlyContinue)) {
        throw "Missing required environment variable: $var"
    }
}
Write-Host "Using Hudu at $env:HUDU_BASE_URL" -ForegroundColor Green

# Run tests
if (-not $FilterTests -or $FilterTests -eq $null){
    $Filter = "*.Tests.ps1"
} else {
    $Filter = "*$FilterTests*.Tests.ps1"
}
$integrationTests = Get-ChildItem -Path $testsPath -Filter $Filter -Recurse

foreach ($integrationTest in $integrationTests) {
    Write-Host "Running: $($integrationTest.Name)" -ForegroundColor Blue
    $config = New-PesterConfiguration
    $config.Run.Path = $integrationTest.FullName
    $config.Output.Verbosity = "detailed"
    Invoke-Pester -Configuration $config
}