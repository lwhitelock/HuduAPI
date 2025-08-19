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
        }

        Write-Host "setting up test for rackstorage, Hudu version $((Get-HuduAppInfo).version)... Prerequisites:`n1: test environment must have a predefined rack storage role."

        $testCompanyId        = [int]$env:HUDU_TEST_COMPANY_ID ?? $(Get-HuduCompanies | Select-Object -First 1).id
        $testRackRoleId       = [int]$env:HUDU_TEST_RACK_ROLE_ID
        $testAssetId          = [int]$env:HUDU_TEST_ASSET_ID ?? $(Get-HuduAssets -CompanyId $testCompanyId | Select-Object -First 1).id

        if (-not $testCompanyId -or -not $testRackRoleId -or -not $testAssetId) {
            throw "Missing required test environment variables (HUDU_TEST_COMPANY_ID, etc.)"
        }
    }

    It "Creates, retrieves, updates, and deletes a RackStorage" {

    # Test 1- rackstorage
        # 1.1 Create
        $rack_name = "IntegrationRack-$(Get-Random)"
        $rack_width = $(Get-Random -Minimum $settings.rack_minwidth -Maximum $settings.rack_maxwidth)
        $rack_height = $(Get-Random -Minimum $settings.rack_minheight -Maximum $settings.rack_maxheight)
        $rack_watts = $(Get-Random -Minimum $settings.rack_minwatts -Maximum $settings.rack_maxwatts)
        $rack_powerdraw = $(Get-Random -Minimum $settings.rack_powerdraw_min -Maximum $settings.rack_powerdraw_max)
        $rack_description = "(from Huduapi module integration tests) $rack_name will be $rack_width units wide, $rack_height units tall with $rack_watts max wattage and $rack_powerdraw powerdraw"
        Write-Host "rack storage for rack storage tests will be named $rack_description"

        $rack = New-HuduRackStorage -Name $rack_name `
                                    -CompanyId $testCompanyId `
                                    -Height $rack_height `
                                    -Width $rack_width `
                                    -MaxWattage $rack_watts `
                                    -Description $rack_description


        write-host $rack
        $rack.id | Should -Not -BeNullOrEmpty
        $rack.width | Should -Be $rack_width
        $rack.height | Should -Be $rack_height
        $rack.max_wattage | Should -Be $rack_watts
        $rack.power_draw_utilization | Should -Be 0
        $rack.description | Should -Be $rack_description        

        Write-Host "Created RackStorage ID: $($rack.id)"

        # 1.2 Retrieve / compare
        Write-Host "Retrieving the rackstorage we created."
        $retrieved = Get-HuduRackStorages -Id $rack.id
        $retrieved.name | Should -Be $rack_name
        $retrieved.width | Should -Be $rack_width
        $retrieved.height | Should -Be $rack_height
        $retrieved.max_wattage | Should -Be $rack_watts
        $retrieved.power_draw_utilization | Should -Be 0
        $retrieved.description | Should -Be $rack_description



        # 1.3 Update / compare
        $updated = Set-HuduRackStorage -Id $rack.id `
                        -Description "$($retrieved.name) Updated from test" `
                        -Width $($retrieved.width + 1) `
                        -Height $($retrieved.height + 1) `
                        -MaxWattage $($retrieved.max_wattage *2)
        write-host $updated
        $updated | Should -Not -BeNullOrEmpty
        $updated.description | Should -Be "$($retrieved.name) Updated from test"
        $updated.width | Should -Be $($retrieved.width + 1)
        $updated.height | Should -Be $($retrieved.height + 1)
        $updated.max_wattage | Should -Be $($retrieved.max_wattage *2)

        # 1.4 - Delete/Clean up
        Remove-HuduRackStorage -Id $rack.id
    }

    # Test 2- rackstorage items
    It "Creates and deletes a RackStorageItem in a new rack." {
        # setup - First create a rack
        $rack_name = "IntegrationRack-$(Get-Random)"
        $rack_width = $(Get-Random -Minimum $settings.rack_minwidth -Maximum $settings.rack_maxwidth)
        $rack_height = $(Get-Random -Minimum $settings.rack_minheight -Maximum $settings.rack_maxheight)
        $rack_watts = $(Get-Random -Minimum $settings.rack_minwatts -Maximum $settings.rack_maxwatts)
        $rack_powerdraw = $(Get-Random -Minimum $settings.rack_powerdraw_min -Maximum $settings.rack_powerdraw_max)
        $rack_description = "(from Huduapi module integration tests) $rack_name will be $rack_width units wide, $rack_height units tall with $rack_watts max wattage and $rack_powerdraw powerdraw"
        Write-Host "rack storage for rack storage item tests will be named $rack_description"

        $rack = New-HuduRackStorage -Name $rack_name `
                                    -CompanyId $testCompanyId `
                                    -Height $rack_height `
                                    -Width $rack_width `
                                    -MaxWattage $rack_watts `
                                    -Description $rack_description

        Write-Host "Test rack created. $rack"
        $side = (Get-Random -Minimum 0 -Maximum 1)
        $StartUnit = 0
        $MaxAllowedWidth = [math]::Min(5, $rack_width - 1)
        $EndUnit = $StartUnit + (Get-Random -Minimum 1 -Maximum ($MaxAllowedWidth + 1))

        Write-Host "Rack item will be created with role id $testRackRoleId"
        #2.1 - create item
        $Item = New-HuduRackStorageItem `
            -RackStorageRoleId $testRackRoleId `
            -AssetId $testAssetId `
            -StartUnit $StartUnit `
            -EndUnit $EndUnit `
            -Side $side `
            -Status 1 `
            -RackStorageId $rack.id `
            -CompanyId $testCompanyId 

        $Item.id | Should -Not -BeNullOrEmpty
        $Item.asset_id | Should -Be $testAssetId
        $Item.company_id | Should -Be $testCompanyId
        $Item.start_unit | Should -Be $StartUnit
        $Item.end_unit | Should -Be $EndUnit
        $Item.side | Should -Be $(if ($side -eq 0) { "front" } else { "rear" })
        Write-Host "Created RackStorageItem ID: $($Item.id)"

        #2.2 Retrieve and compare
        $retrievedItem = Get-HuduRackStorageItems -Id $Item.id
        $retrievedItem.start_unit | Should -Be $StartUnit
        $retrievedItem.end_unit | Should -Be $EndUnit
        $retrievedItem.side | Should -Be $Item.side

        #2.3 Update and validate
        $updatedItem = Set-HuduRackStorageItem `
            -Id $Item.id `
            -EndUnit ($EndUnit + 1)

        $updatedItem.id | Should -Be $Item.id
        $updatedItem.end_unit | Should -Be ($EndUnit + 1)

        # Cleanup
        Remove-HuduRackStorageItem -Id $Item.id
        Remove-HuduRackStorage -Id $rack.id
    }
}