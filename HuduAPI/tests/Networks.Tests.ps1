# Tests/Lists.Tests.ps1
Context "Hudu Networks / IPAM Integration Tests" {

    BeforeEach {
        $HUDU_API_KEY  = $env:HUDU_API_KEY  ?? "$(Read-Host 'Enter Hudu API Key')"
        $HUDU_BASE_URL = $env:HUDU_BASE_URL ?? "$(Read-Host 'Enter Hudu Base URL')"

        New-HuduBaseURL $HUDU_BASE_URL
        New-HuduApiKey $HUDU_API_KEY
        $testCompanyId        = [int]$env:HUDU_TEST_COMPANY_ID ?? $(Get-HuduCompanies | Select-Object -First 1).id
        if (-not $testCompanyId ) {
            throw "Missing required test environment variable- testCompanyId= $testCompanyId)"
        }
        Write-Host "Setting up test for Networks endpoint... Hudu version: $((Get-HuduAppInfo).version)"
        function Get-RandomIPV4Range {
            param(
                [int]$MinPrefix = 8,
                [int]$MaxPrefix = 30,
                [bool]$AvoidReservedFirstOctet=$true
            )

            if ($AvoidReservedFirstOctet) {
                do { $b0 = Get-Random -Minimum 1 -Maximum 224 } while ($b0 -eq 127)
                $bytes = @([byte]$b0) + (1..3 | ForEach-Object { [byte](Get-Random -Minimum 0 -Maximum 252) })
            } else {
                $bytes = 0..3 | ForEach-Object { [byte](Get-Random -Minimum 0 -Maximum 252) }
            }

            $ip = [System.Net.IPAddress]::new($bytes)
            $prefix   = Get-Random -Minimum $MinPrefix -Maximum ($MaxPrefix + 1)
            $hostBits = 32 - $prefix
            $mask     = [uint32](-bnot ([uint32]((1 -shl $hostBits) - 1)))

            # align to network
            $ipBytes = $ip.GetAddressBytes(); [array]::Reverse($ipBytes)
            $ipInt   = [BitConverter]::ToUInt32($ipBytes, 0)
            $netInt  = $ipInt -band $mask
            $netBytes = [BitConverter]::GetBytes($netInt); [array]::Reverse($netBytes)
            $netIp    = [System.Net.IPAddress]::new($netBytes)

            return "$netIp/$prefix"
        }
    
    }

    It "Creates a number of randomly-generated networks/addresses" {
        $addressesToCreate  = Get-Random -Minimum 10 -Maximum 16
        $allNetworks        = Get-HuduNetworks
        $addressCount       = ($allNetworks).Count
        $createdNetworks    = @()
        $modifiedNetworks   = @()
        $archivedNetworks   = @()
        $deletedNetworks    = @()
        Write-Host "Current Address count in Hudu is $addressCount. Set to create, check, update, check, then delete $addressesToCreate new addresses."

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
