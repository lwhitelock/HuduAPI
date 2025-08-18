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
    }

    It "Creates a number of randomly-generated networks/addresses" {
        $MinPrefix = 8
        $MaxPrefix = 30

        $addressesToCreate = Get-Random -Minimum 10 -Maximum 16
        $addressList = New-Object System.Collections.Generic.List[string]
        $addressCount = (Get-HuduNetworks ?? @()).Count
        $createdNetworks = @()
        Write-Host "Current Address count in Hudu is $addressCount. Set to create, check, update, check, then delete $addressesToCreate new addresses."

        foreach ($i in 1..$numAddresses) {
            $bytes = 0..3 | ForEach-Object { [byte](Get-Random -Minimum 0 -Maximum 256) }
            $ip    = [System.Net.IPAddress]::new($bytes)

            $prefix = Get-Random -Minimum $MinPrefix -Maximum ($MaxPrefix + 1)

            $hostBits = 32 - $prefix
            $mask = [uint32](-bnot ([uint32]((1 -shl $hostBits) - 1)))

            $ipBytes = $ip.GetAddressBytes()
            [array]::Reverse($ipBytes)
            $ipInt = [BitConverter]::ToUInt32($ipBytes, 0)

            $netInt = $ipInt -band $mask

            $netBytes = [BitConverter]::GetBytes($netInt)
            [array]::Reverse($netBytes)
            $netIp = [System.Net.IPAddress]::new($netBytes)
            $description = "$([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant()) is $([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant()) for $([Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant())"
            
            $name = [Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(6)).ToLowerInvariant()
            $newAddress = @{
                Name        = "TestNetwork-$name"
                Address     = "$netIp/$prefix"
                CompanyId   = $testCompanyId
                Description = $description
            }
            $addressList.Add($newAddress)
        }        

        foreach ($address in $addressList){
            Write-Host "creating network: $($($address | ConvertTo-Json -depth 6).ToString())"
            $createdNetwork = New-HuduNetwork @address
            $createdNetwork.name | Should -Be $address.Name
            $createdNetwork.description | Should -Be $address.Description
            $createdNetwork.company_id | Should -Be $address.CompanyId
            $createdNetwork.Address | Should -Be $address.address
            $createdNetworks+=$createdNetworks
        }
    }

}
