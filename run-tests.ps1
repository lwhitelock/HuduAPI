#!/usr/bin/env pwsh
# Run-HuduTests.ps1

param (
    [string]$TestPath = "$PSScriptRoot\HuduAPI\Tests\Rack-Storage.Tests.ps1",
    [string]$EnvironFile,
    [switch]$VerboseOutput  
)

$modulePath = Join-Path $PSScriptRoot 'HuduAPI\Huduapi.psd1'
Remove-Module Huduapi -ErrorAction SilentlyContinue
Import-Module $modulePath -Force

# Ensure Pester 5+
$requiredVersion = "5.0.0"
if (-not (Get-Module -ListAvailable Pester | Where-Object { $_.Version -ge $requiredVersion })) {
    Write-Host "Installing Pester $requiredVersion+..." -ForegroundColor Yellow
    Install-Module Pester -Scope CurrentUser -Force -SkipPublisherCheck
}

# Reload latest Pester
Remove-Module Pester -ErrorAction SilentlyContinue
Import-Module Pester -MinimumVersion $requiredVersion -Force

# Optional: Load environment from .env file
$envFile = $(join-path "$PSScriptRoot\tests" "$EnvironFile")
if (Test-Path $envFile) {
    Write-Host "Sourcing environment variables from $envFile" -ForegroundColor Cyan
    . $envFile
}

# Confirm key =env vars
$requiredVars = "HUDU_API_KEY", "HUDU_BASE_URL"
foreach ($var in $requiredVars) {
    if (-not (Get-Item -Path "env:$var" -ErrorAction SilentlyContinue)) {
        throw "Missing required environment variable: $var"
    }
}
Write-Host "Using Hudu at ${env:HUDU_BASE_URL}" -ForegroundColor Green

# Run tests
$configuration = New-PesterConfiguration
$configuration.Run.Path = $TestPath
$configuration.Output.Verbosity = if ($VerboseOutput) { "Detailed" } else { "Normal" }

Invoke-Pester -Configuration $configuration
