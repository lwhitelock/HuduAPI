
# Tests/Lists.Tests.ps1
Context "Hudu VLAN / VLAN Zones Integration Tests" {

    BeforeEach {
        $HUDU_API_KEY  = $env:HUDU_API_KEY  ?? "$(Read-Host 'Enter Hudu API Key')"
        $HUDU_BASE_URL = $env:HUDU_BASE_URL ?? "$(Read-Host 'Enter Hudu Base URL')"

        New-HuduBaseURL $HUDU_BASE_URL
        New-HuduApiKey $HUDU_API_KEY
        if (-not $env:HUDU_TEST_COMPANY_ID ) {
            throw "Missing required test environment variable- testCompanyId= $HUDU_TEST_COMPANY_ID)"
        } else {$HUDU_TEST_COMPANY_ID=$env:HUDU_TEST_COMPANY_ID}
        if (-not $env:HUDU_TEST_VLAN_ID ) {
            throw "Missing required test environment variable- testCompanyId= $HUDU_TEST_VLAN_ID)"
        } else {$HUDU_TEST_VLAN_ID=$env:HUDU_TEST_VLAN_ID}
        if (-not $env:RoleListItemID ) {
            throw "Missing required test environment variable- testCompanyId= $RoleListItemID)"
        } else {$RoleListItemID=$env:RoleListItemID}
        if (-not $env:StatusListItemID ) {
            throw "Missing required test environment variable- testCompanyId= $StatusListItemID)"
        } else {$StatusListItemID=$env:StatusListItemID}
        function Get-RandomVlanRange {
            param(
                [int]$Min = 1,
                [int]$Max = 4094
            )
            $start = Get-Random -Minimum $Min -Maximum $Max
            $end   = Get-Random -Minimum $start -Maximum ($Max + 1)
            return "$start-$end"
        }        
        function Get-RandomHexString {
            param (
                [int]$bytes=8
            )
            return "$([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes($bytes)).ToLowerInvariant())"
        }

        $testCompany        = Get-HuduCompanies -id $env:HUDU_TEST_COMPANY_ID
        $testVLAN.          = Get-Hudu -id $env:HUDU_TEST_COMPANY_ID
        Write-Host "Setting up test for Vlan and Vlan Zones endpoints using test VLAN $... Hudu version: $((Get-HuduAppInfo).version)"
    }

    It "Creates, verifies, updates, verifies, archives, unarchives, deletes vlan and vlan zones." {

        $testCompany = 
        $vlanInfo = @{
            Required = $(Get-Random -Minimum 8 -Maximum 12)
            VLanIDs = @()
            Created = @()

        }
        $zonesInfo = @{
            MaxZones = $(Get-Random -Minimum 3 -Maximum 5)
            Created = @()
        }


        Write-Host "creating $($vlanInfo.Required) VLans with $($zonesInfo.Required) Zones each for test company $($testCompany.name)"
        
        for ($i = 1; $i -le $wlanInfo.Required; $i++) {
            $NewVLANId = $(Get-Random -Minimum 4 -Maximum 4094)
            $NewVLANId = $(if ($vlanInfo.VlanIds -contains $NewVLANId) {$(Get-Random -Minimum 4 -Maximum 4094)} else $NewVLANId)
            $vlanInfo.VLanIDs+=$NewVLANId
            Write-Host "Creating vlan $i of $($wlanInfo.Required) with vlan Id $NewVLANId"

            $VlanRequest = @{
                Name        = "Vlan-$(Get-RandomHexString -bytes 12)-$i-of-$($($wlanInfo.Required))"
                CompanyId   = $testCompany.Id
                VLANId      = $NewVLANId
                Description = "VLAN from Integration Test $(Get-RandomHexString -bytes 2) $(Get-RandomHexString -bytes 4) $(Get-RandomHexString -bytes 6)."
            }
            if ($(Get-Random -Minimum 0 -Maximum 1) -eq 1){
                $VlanRequest["StatusListItemID"] =$StatusListItemID
            }
            if ($(Get-Random -Minimum 0 -Maximum 1) -eq 1){
                $VlanRequest["RoleListItemID"] = $RoleListItemID
            }
            $createdVLAN = New-HuduVLAN @request
            $vlanInfo.Created+=$createdVLAN

            $createdVLAN.Name | Should -Be $VlanRequest.Name
            $createdVLAN.CompanyId | Should -Be $VlanRequest.CompanyId
            $createdVLAN.VLANId | Should -Be $VlanRequest.VLANId
            $createdVLAN.Description | Should -Be $VlanRequest.Description
            if ($VlanRequest["RoleListItemID"] -and $null -ne $VlanRequest["RoleListItemID"]) {
                $createdVLAN.RoleListItemID Should -Be $VlanRequest["RoleListItemID"]
            }
            if ($VlanRequest["StatusListItemID"] -and $null -ne $VlanRequest["StatusListItemID"]) {
                $createdVLAN.StatusListItemID Should -Be $VlanRequest["StatusListItemID"]
            }
            $zonesToCreate = $(Get-Random -Minimum 1 -Maximum $zonesInfo.MaxZones)
            for ($d = 1; $d -le $zonesToCreate; $d++) {
                
                Write-Host "Creating vlan zone $d of $($zonesToCreate) for vlan $($VlanRequest.Name), $i of $($wlanInfo.Required)"
                $ZoneRequest = @{
                    Name              = "Zone-$(Get-RandomHexString -bytes 3)-$(Get-RandomHexString -bytes 3)-$d-of-$($($zonesToCreate))"
                    CompanyId         = $testCompany.Id
                    VlanIDRanges      = $(Get-RandomVlanRange)
                    Description = "VLAN Zone from Integration Test $(Get-RandomHexString -bytes 2) $(Get-RandomHexString -bytes 16)."
                }
                $newVLanZone = New-HuduVlanZone @ZoneRequest
                $zonesInfo.Created +=$newVLanZone
                $createdVLAN.Name | Should -Be $ZoneRequest.Name
                $createdVLAN.CompanyId | Should -Be $ZoneRequest.CompanyId
                $createdVLAN.VlanIDRanges | Should -Be $ZoneRequest.VlanIDRanges
                $createdVLAN.Description | Should -Be $ZoneRequest.Description
            }
        }

        Write-Host "Created $($vlanInfo.Created.Count) Vlans with $($zonesInfo.Created.Count) total Zones. Now Modifying and Archiving, then deleting"






    }

}
