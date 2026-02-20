# Tests/Flags-FlagTypes.Tests.ps1

Context "Hudu Flags and Flag Types Integration Tests" {

    BeforeEach {
        $HUDU_API_KEY  = $env:HUDU_API_KEY  ?? "$(Read-Host 'Enter Hudu API Key')"
        $HUDU_BASE_URL = $env:HUDU_BASE_URL ?? "$(Read-Host 'Enter Hudu Base URL')"

        New-HuduBaseURL $HUDU_BASE_URL
        New-HuduApiKey $HUDU_API_KEY
        if (-not $env:HUDU_TEST_ASSET_ID){throw "Missing required test environment variable- HUDU_TEST_ASSET_ID"}
        if (-not $env:HUDU_TEST_COMPANY_ID){throw "Missing required test environment variable- HUDU_TEST_COMPANY_ID"}
        if (-not $env:HUDU_TEST_NETWORK_ID){throw "Missing required test environment variable- HUDU_TEST_NETWORK_ID"}
        if (-not $env:HUDU_TEST_VLAN_ID){throw "Missing required test environment variable- HUDU_TEST_VLAN_ID"}
        if (-not $env:HUDU_TEST_VLAN_ZONE_ID){throw "Missing required test environment variable- HUDU_TEST_VLAN_ZONE_ID"}
        if (-not $env:HUDU_TEST_IP_ADDRESS_ID){throw "Missing required test environment variable- HUDU_TEST_IP_ADDRESS_ID"}

        $currentVersion = ([version]$((Get-HuduAppInfo).version))
        if ($currentVersion -lt [version]"2.4.0") {
            throw "Hudu version 2.4.0 or higher is required for Flags and Flag Types tests. Current version: $currentVersion"
        } else {
            Write-Host "Setting up test for Flags endpoints... Hudu version: $currentVersion"
        }
        $TestCompany = Get-HuduCompanies -Id $env:HUDU_TEST_COMPANY_ID; $TestCompany=$TestCompany.company ?? $TestCompany;
        if (-not $TestCompany) {
            throw "HUDU_TEST_COMPANY_ID ($env:HUDU_TEST_COMPANY_ID) does not correspond to a valid Company in Hudu."
        } else {
            write-host "Using test Company: id=$($TestCompany.id), name=$($TestCompany.name)"
        }
        $LayoutForAssetAttribution = $(get-huduassetlayouts | where-object { -not ($_.active -eq $false) } | select-object -first 1)
        $LayoutForAssetAttribution = $LayoutForAssetAttribution.asset_layout ?? $LayoutForAssetAttribution
        if (-not $LayoutForAssetAttribution) {
            throw "No active Asset Layouts found in Hudu; at least one is required for Flag tests."
        } else {
            write-host "Using Asset Layout for flaggable Asset creation: id=$($LayoutForAssetAttribution.id), name=$($LayoutForAssetAttribution.name)"
        }
        $flaggables = @{}
        $flaggables["Asset"] = $env:HUDU_TEST_ASSET_ID
        $flaggables["Company"] = $env:HUDU_TEST_COMPANY_ID
        $flaggables["Network"] = $env:HUDU_TEST_NETWORK_ID
        $flaggables["IpAddress"] = $env:HUDU_TEST_IP_ADDRESS_ID
        $flaggables["Vlan"] = $env:HUDU_TEST_VLAN_ID
        $flaggables["VlanZone"] = $env:HUDU_TEST_VLAN_ZONE_ID
        $flaggables["RackStorage"] = $env:HUDU_TEST_RACK_STORAGE_ID
        $flaggables["Website"] = $env:HUDU_TEST_WEBSITE_ID
        $flaggables["Article"] = $env:HUDU_TEST_ARTICLE_ID
        $flaggables["AssetPassword"] = $env:HUDU_TEST_PASSWORD_ID
        $flaggables["Procedure"] = $env:HUDU_TEST_PROCEDURE_ID
    
    }

    It "Creates, retrieves, updates, and deletes Flag Types and Flags" {
        $allFlagColors = @('Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange', 'LightPink', 'LightBlue', 'LightGreen', 'LightPurple', 'LightOrange', 'LightYellow', 'White', 'Grey')
        $allFlagTypes = @('Asset','Website','Article','AssetPassword','Company','Procedure','RackStorage','Network','IpAddress','Vlan','VlanZone')

        foreach ($flagable_type in $allFlagTypes) {
            $flagTypeName  = "IntegrationTestFlagType-$(Get-Random)"
            $flagTypeColor = $allFlagColors | Get-Random            
            $flagable_id = $flaggables["$flagable_type"]

            write-host "starting flag tests for flagable type: $flagable_type, (object id: $flagable_id) will be using flag type name: $flagTypeName and color: $flagTypeColor"

            $createdFlagType = $null
            $createdFlag     = $null

            try {
                $createdFlagType = New-HuduFlagType -Name $flagTypeName -Color $flagTypeColor
                $createdFlagType | Should -Not -BeNullOrEmpty
                $createdFlagType.id | Should -BeGreaterThan 0
                $createdFlagType.name | Should -Be $flagTypeName
                $createdFlagType.color | Should -Be $flagTypeColor

                Write-Host "Created flag type: $($createdFlagType | ConvertTo-Json -Depth 6)"

                # 1.2 Retrieve Flag Type by ID
                $fetchedFTById = Get-HuduFlagTypes -Id $createdFlagType.id
                $fetchedFTById | Should -Not -BeNullOrEmpty
                $fetchedFTById.id | Should -Be $createdFlagType.id
                $fetchedFTById.name | Should -Be $flagTypeName

                # 1.3 Retrieve Flag Types by filter (Name)
                # (Get endpoints can return an array; handle both single and multi)
                $fetchedFTByName = @(Get-HuduFlagTypes -Name $flagTypeName)
                $fetchedFTByName.Count | Should -BeGreaterThan 0
                ($fetchedFTByName.id -contains $createdFlagType.id) | Should -BeTrue

                # 1.4 Update Flag Type
                $updatedFTName  = "$flagTypeName-Updated"
                $updatedFTColor = $allFlagColors | Where-Object { $_ -ne $flagTypeColor } | Get-Random

                $updatedFT = Set-HuduFlagType -Id $createdFlagType.id -Name $updatedFTName -Color $updatedFTColor
                $updatedFT | Should -Not -BeNullOrEmpty

                # depending on your wrapper, Set may return full response or unwrapped object
                $updatedFTObj = $updatedFT.flag_type ?? $updatedFT
                $updatedFTObj.name | Should -Be $updatedFTName
                $updatedFTObj.color | Should -Be $updatedFTColor

                # refresh
                $refetchedFT = Get-HuduFlagTypes -Id $createdFlagType.id
                $refetchedFT.name | Should -Be $updatedFTName
                $refetchedFT.color | Should -Be $updatedFTColor


                # -------------------------
                # 2) FLAG CRUD
                # -------------------------

                # 2.1 Create Flag
                $flagDesc = "Integration test flag - $(Get-Random)"

                $createdFlag = New-HuduFlag -FlagTypeId $createdFlagType.id -Description $flagDesc -flagable_type $flagable_type -flagable_id $flagable_id
                $createdFlag | Should -Not -BeNullOrEmpty
                $createdFlag.id | Should -BeGreaterThan 0
                $createdFlag.flag_type_id | Should -Be $createdFlagType.id
                $createdFlag.flagable_type | Should -Be $flagable_type
                $createdFlag.flagable_id | Should -Be $flagable_id
                $createdFlag.description | Should -Be $flagDesc

                Write-Host "Created flag: $($createdFlag | ConvertTo-Json -Depth 6)"

                # 2.2 Retrieve Flag by ID
                $fetchedFById = Get-HuduFlags -id $createdFlag.id
                $fetchedFById | Should -Not -BeNullOrEmpty
                $fetchedFById.id | Should -Be $createdFlag.id
                $fetchedFById.description | Should -Be $flagDesc

                # 2.3 Retrieve Flags by filter (flagable)
                $fetchedFByTarget = @(Get-HuduFlags -flagable_type $flagable_type -flagable_id $flagable_id)
                $fetchedFByTarget.Count | Should -BeGreaterThan 0
                ($fetchedFByTarget.id -contains $createdFlag.id) | Should -BeTrue

                # 2.4 Update Flag (description + (optionally) flag_type)
                $updatedDesc = "$flagDesc (updated)"

                $updatedFlag = Set-HuduFlag -Id $createdFlag.id -Description $updatedDesc
                $updatedFlag | Should -Not -BeNullOrEmpty

                $updatedFlagObj = $updatedFlag.flag ?? $updatedFlag
                $updatedFlagObj.description | Should -Be $updatedDesc

                # refresh
                $refetchedFlag = Get-HuduFlags -id $createdFlag.id
                $refetchedFlag.description | Should -Be $updatedDesc


                # -------------------------
                # 3) CLEANUP (delete flag first, then flag type)
                # -------------------------

                # 3.1 Delete Flag
                $removedFlag = Remove-HuduFlag -Id $createdFlag.id -confirm:$false
                # your Remove may return $true; if it returns nothing, that's fine too
                # (assert by re-fetch)
                $deletedFlag = Get-HuduFlags | where-object { $_.id -eq $createdFlag.id }
                $deletedFlag | Should -BeNullOrEmpty

                # 3.2 Delete Flag Type
                $removedFT = Remove-HuduFlagType -Id $createdFlagType.id -confirm:$false
                $deletedFT = Get-HuduFlagTypes | where-object { $_.id -eq $createdFlagType.id }
                $deletedFT | Should -BeNullOrEmpty
            }
            finally {
                # Best-effort cleanup in case the test fails mid-way.
                if ($createdFlag -and $createdFlag.id) {
                    try { Remove-HuduFlag -Id $createdFlag.id -confirm:$false | Out-Null } catch {}
                }

                if ($createdFlagType -and $createdFlagType.id) {
                    try { Remove-HuduFlagType -Id $createdFlagType.id -confirm:$false | Out-Null } catch {}
                }
            }
        }
    }
}
