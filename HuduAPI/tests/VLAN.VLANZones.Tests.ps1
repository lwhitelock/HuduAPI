
# Tests/Lists.Tests.ps1
Context "Hudu VLAN / VLAN Zones Integration Tests" {

    BeforeEach {
        $HUDU_API_KEY  = $env:HUDU_API_KEY  ?? "$(Read-Host 'Enter Hudu API Key')"
        $HUDU_BASE_URL = $env:HUDU_BASE_URL ?? "$(Read-Host 'Enter Hudu Base URL')"

        New-HuduBaseURL $HUDU_BASE_URL
        New-HuduApiKey $HUDU_API_KEY
        if (-not $env:HUDU_TEST_COMPANY_ID ) {
            throw "Missing required test environment variable- testCompanyId= $HUDU_TEST_COMPANY_ID)"
        }
        if (-not $env:HUDU_TEST_VLAN_ID ) {
            throw "Missing required test environment variable- testCompanyId= $HUDU_TEST_VLAN_ID)"
        }
        $testCompany        = Get-HuduCompanies -id $env:HUDU_TEST_COMPANY_ID
        $testVLAN.          = Get-Hudu -id $env:HUDU_TEST_COMPANY_ID
        Write-Host "Setting up test for Vlan and Vlan Zones endpoints using test VLAN $... Hudu version: $((Get-HuduAppInfo).version)"
    }

    It "Creates, verifies, updates, verifies, archives, unarchives, deletes vlan and vlan zones." {

        $testCompany = 
        $vlanInfo = @{
            Required = $(Get-Random -Minimum 8 -Maximum 12)
            Created = @()
        }
        $zonesInfo = @{
            Required = $(Get-Random -Minimum 3 -Maximum 5)
            Created = @()
        }


        Write-Host "creating $($vlanInfo.Required) VLans with $($zonesInfo.Required) Zones each for test company"

        for ($i = 1; $i -le $addressesToCreate; $i++) {
            $name = [Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant()
            $newAddress = @{
                Name        = "TestNetwork-$name"
                Address     = $(Get-RandomIPV4Range)
                CompanyId   = $testCompanyId
                Description = "$([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant()) is $([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant()) for $([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant())"
            }
            Write-Host "creating network $($newAddress.Name), $($newAddress.Address), $($newAddress.Description) for company id: $($newAddress.CompanyId)"
            $createdNetwork = New-HuduNetwork -Name $newAddress.Name -CompanyId $newAddress.CompanyId -Description $newAddress.Description -Address $newAddress.address
            $createdNetwork.name | Should -Be $newAddress.Name
            $createdNetwork.description | Should -Be $newAddress.Description
            $createdNetwork.company_id | Should -Be $newAddress.CompanyId
            $createdNetwork.Address | Should -Be $newAddress.address
            $retrievedNetwork = Get-HuduNetworks -id $createdNetwork.id
            # $retrievedNetwork.description | Should -Be $createdNetwork.Description
            # $retrievedNetwork.company_id | Should -Be $createdNetwork.CompanyId
            # $retrievedNetwork.Address | Should -Be $createdNetwork.address
            $createdNetworks += $createdNetwork
        }
        Write-host "Successfully created/retrieved $($createdNetworks.count) Networks."

        foreach ($originalAddress in $createdNetworks){
            $modified= @{
                Name        = "$($originalAddress.name)-Modified-$([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(4)).ToLowerInvariant())"
                Address     = $(Get-RandomIPV4Range)
                CompanyId   = $testCompanyId
                NetworkType = $(Get-Random -Minimum 0 -Maximum 4)
                Description = "Modified $([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(8)).ToLowerInvariant()) is $([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(8)).ToLowerInvariant()) as $([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(8)).ToLowerInvariant())"
            }
            Write-Host "Modifying network $($originalAddress.Name)=>$($modified.name), $($originalAddress.Address)=>$($modified.Address), $($originalAddress.Description)=>$($modified.Description) for address $($originalAddress.id)"
            $modifiedNetwork=Set-HuduNetwork -id $originalAddress.id -name $modified.name -CompanyId $modified.CompanyId -Description $modified.Description -NetworkType $modified.NetworkType -Address $modified.Address
            $modifiedNetwork.id | Should -Be $originalAddress.id
            $modifiedNetwork.name | Should -Be $modified.Name
            $modifiedNetwork.description | Should -Be $modified.Description
            $modifiedNetwork.network_type | Should -Be $modified.NetworkType
            $modifiedNetwork.company_id | Should -Be $modified.CompanyId
            $modifiedNetwork.address | Should -Be $modified.address
            $modifiedNetwork.name | Should -Not -Be $originalAddress.Name
            $modifiedNetwork.description | Should -Not -Be $originalAddress.Description
            $modifiedNetwork.company_id | Should -Not -Be $originalAddress.CompanyId
            $modifiedNetwork.address | Should -Not -Be $originalAddress.address
            $modifiedNetworks += $modifiedNetwork
        }

        Write-host "Successfully modified $($modifiedNetworks.count) Networks."
        

        foreach ($modifiedNetwork in $modifiedNetworks){
            $removedNetwork = Remove-HuduNetwork -id $modifiedNetwork.id
            $deletedNetworks += $removedNetwork
        }

        Write-host "Successfully deleted $($deletedNetworks.count) Networks."

        $allNetworks        = Get-HuduNetworks
        $allNetworkIds      = $allNetworks.id
        $allNetworks.count | Should -Be $addressCount




    }

}
