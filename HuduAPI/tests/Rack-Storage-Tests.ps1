# Tests/RackStorages.Tests.ps1
$ErrorActionPreference = "Stop"
Import-Module "$PSScriptRoot/../YourModuleName.psd1" -Force

Describe "Hudu RackStorage Integration Tests" {

    BeforeAll {
        # Load test config from env vars or inline fallback
        $env:HUDU_API_KEY     = $env:HUDU_API_KEY     ?? "your-api-key"
        $env:HUDU_BASE_URL    = $env:HUDU_BASE_URL    ?? "https://your.huducloud.com"
        $testCompanyId        = [int]$env:HUDU_TEST_COMPANY_ID
        $testRackRoleId       = [int]$env:HUDU_TEST_RACK_ROLE_ID
        $testAssetId          = [int]$env:HUDU_TEST_ASSET_ID

        if (-not $testCompanyId -or -not $testRackRoleId -or -not $testAssetId) {
            throw "Missing required test environment variables (HUDU_TEST_COMPANY_ID, etc.)"
        }
    }

    It "Creates, retrieves, updates, and deletes a RackStorage" {
        # Create
        $rack = New-HuduRackStorage -Name "IntegrationRack-$(Get-Random)" `
            -CompanyId $testCompanyId -Height 42 -Width 600
        $rack.id | Should -Not -BeNullOrEmpty
        Write-Host "Created RackStorage ID: $($rack.id)"

        # Retrieve
        $retrieved = Get-HuduRackStorage -Id $rack.id
        $retrieved.name | Should -Be $rack.name

        # Update
        $updated = Set-HuduRackStorage -Id $rack.id -Description "Updated from test"
        $updated | Should -Not -BeNullOrEmpty

        # Clean up
        Remove-HuduRackStorage -Id $rack.id -Confirm:$false
    }

    It "Creates and deletes a RackStorageItem" {
        # First create a rack
        $rack = New-HuduRackStorage -Name "RackForItem-$(Get-Random)" `
            -CompanyId $testCompanyId -Height 42 -Width 600

        $item = New-HuduRackStorageItem `
            -RackStorageRoleId $testRackRoleId `
            -AssetId $testAssetId `
            -StartUnit 1 `
            -EndUnit 4 `
            -Side "Front" `
            -CompanyId $testCompanyId

        $item.id | Should -Not -BeNullOrEmpty
        Write-Host "Created RackStorageItem ID: $($item.id)"

        Remove-HuduRackStorageItem -Id $item.id -Confirm:$false
        Remove-HuduRackStorage -Id $rack.id -Confirm:$false
    }
}
