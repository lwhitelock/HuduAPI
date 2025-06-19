# Tests/RackStorages.Tests.ps1



Context "Hudu RackStorage Integration Tests" {

    BeforeEach {
        # Load test config from env vars or inline fallback
        $HUDU_API_KEY     = $env:HUDU_API_KEY     ?? "$(read-host "enter hudu api key for rackstorage test")"
        $HUDU_BASE_URL    = $env:HUDU_BASE_URL    ?? "$(read-host "enter hudu base url for rackstorage test")"
        new-hudubaseurl $hudu_base_url
        new-huduapikey $hudu_api_key
        $settings =@{
            rack_maxwidth=1200
            rack_minwidth=2
            rack_maxheight=1200
            rack_minheight=2
            rack_maxwatts=96000
            rack_minwatts=1200
            rack_powerdraw_min=9600
            rack_powerdraw_max=12700
            rack_reservedmessage="hey, this is reserved, buddy!"
        }

        Write-Host "setting up test for rackstorage, Hudu version $((Get-HuduAppInfo).version)... Prerequisites:`n1: test environment must have a predefined rack storage role."

        $testCompanyId        = [int]$(Get-HuduCompanies | Select-Object -First 1).id
        $testRackRoleId       = [int]$env:HUDU_TEST_RACK_ROLE_ID ?? 1
        $testAssetId          = [int]$(Get-HuduAssets -CompanyId $testCompanyId | Select-Object -First 1).id

        if (-not $testCompanyId -or -not $testRackRoleId -or -not $testAssetId) {
            throw "Missing required test environment variables (HUDU_TEST_COMPANY_ID, etc.)"
        }
    }

    It "Creates, retrieves, updates, and deletes a RackStorage" {
        # Create
        $rack = New-HuduRackStorage -Name "IntegrationRack-$(Get-Random)" `
            -CompanyId $testCompanyId -Height 42 -Width 600
        write-host $rack
        $rack.id | Should -Not -BeNullOrEmpty
        Write-Host "Created RackStorage ID: $($rack.id)"

        # Retrieve
        $retrieved = Get-HuduRackStorage -Id $rack.id
        $retrieved.name | Should -Be $rack.name

        # Update
        $updated = Set-HuduRackStorage -Id $rack.id -Description "Updated from test"
        write-host $updated
        $updated | Should -Not -BeNullOrEmpty

        # Clean up
        Remove-HuduRackStorage -Id $rack.id
    }

    It "Creates and deletes a RackStorageItem" {
        # First create a rack
        $rack_width = $(Get-Random -Minimum $settings.rack_minwidth -Maximum $settings.rack_maxwidth)
        $rack_height = $(Get-Random -Minimum $settings.rack_minheight -Maximum $settings.rack_maxheight)
        $side = (Get-Random -Minimum 0 -Maximum 1)
        $item_width = $(get-random -minimum 1 -maximum $($rack_width - 1))
        $StartUnit = 0
        $MaxAllowedWidth = [math]::Min(5, $rack_width - 1)
        $EndUnit = $StartUnit + (Get-Random -Minimum 1 -Maximum ($MaxAllowedWidth + 1))
        Write-Host "rack storage will be $rack_width units wide, $rack_height units tall"
        $rack = New-HuduRackStorage -Name "RackForItem-$(Get-Random)" `
            -CompanyId $testCompanyId `
            -Height $rack_height `
            -Width $rack_width

        $Item = New-HuduRackStorageItem `
            -RackStorageRoleId $testRackRoleId `
            -AssetId $testAssetId `
            -StartUnit $startunit `
            -EndUnit $endunit `
            -Side $side `
            -Status 1 `
            -RackStorageId $rack.id `
            -CompanyId $testCompanyId



        $item.id | Should -Not -BeNullOrEmpty
        Write-Host "Created RackStorageItem ID: $($item.id)"

        Remove-HuduRackStorageItem -Id $item.id 
        Remove-HuduRackStorage -Id $rack.id
    }
}