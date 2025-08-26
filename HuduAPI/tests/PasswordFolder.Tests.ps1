# Tests/Lists.Tests.ps1

Context "Hudu Password Folders Integration Tests" {

    BeforeEach {
        $HUDU_API_KEY  = $env:HUDU_API_KEY  ?? "$(Read-Host 'Enter Hudu API Key')"
        $HUDU_BASE_URL = $env:HUDU_BASE_URL ?? "$(Read-Host 'Enter Hudu Base URL')"

        New-HuduBaseURL $HUDU_BASE_URL
        New-HuduApiKey $HUDU_API_KEY

        Write-Host "Setting up test for Lists endpoint... Hudu version: $((Get-HuduAppInfo).version)"
        
        function Get-RandomHexString { param([int]$bytes=8)
        [Convert]::ToHexString([Security.Cryptography.RandomNumberGenerator]::GetBytes($bytes)).ToLowerInvariant()
        }

        $testCompany = Get-HuduCompanies -Id $env:HUDU_TEST_COMPANY_ID
        $null = $testCompany | Should -Not -BeNullOrEmpty
    }

    It "Creates, retrieves, updates, and deletes a series of generated password folders" {
        $allGroups = Get-HuduGroups
        $passwordFoldersToCreate = $(get-Random -Minimum 6 -Maximum 10)
        $passwordFolderData = @{
            Requested = @()

        }
        for ($i = 1; $i -le $passwordFoldersToCreate; $i++) {
            if ($(get-Random -Minimum 0 -Maximum 10) -gt 5) {
                $passFolderRequest= @{
                    Security = "all_users"
                }
                Write-Host "Password Folder $i of $passwordFoldersToCreate will be set to 'all_users'"
            } else {
                $passFolderRequest= @{
                    Security = "specific"
                    AllowedGroups = $(if ($allgroups.count -gt 2) {$($allGroups | Get-Random -count $($allgroups.count -1))} else {@(0)})
                }
                Write-Host "Password Folder $i of $passwordFoldersToCreate will be set to 'specific' security groups $($passFolderRequest.AllowedGroups)"
            }
            $passFolderRequest.Name = "$(Get-RandomHexString -bytes $(get-random -Minimum 12 -Maximum 16)) $(Get-RandomHexString -bytes $(get-random -Minimum 4 -Maximum 8))"
            $passFolderRequest.Description = "Test Password Folder, $($passFolderRequest.Name). It contains $(Get-RandomHexString -bytes $(get-random -Minimum 12 -Maximum 16))"
            $passFolderRequest.CompanyId = $testCompany.id
            $passwordFolderData.Requested += $passFolderRequest

            Write-Host "creating password folder $($passFolderRequest.Name) ($i of $passwordFoldersToCreate) with random security, name, groups, and description"
            $newPasswordFolder = New-HuduPasswordFolder @passFolderRequest
            
            $newPasswordFolder.name               | Should -Be $passFolderRequest.Name
            $newPasswordFolder.company_id         | Should -Be $passFolderRequest.CompanyId
            $newPasswordFolder.security           | Should -Be $passFolderRequest.Security
            $newPasswordFolder.description        | Should -Be $passFolderRequest.Description

            Write-Host "retrieving password folder ($i of $passwordFoldersToCreate) $($newPasswordFolder.name) and comparing properties to ensure as-expected"
            $retrievedPasswordFolder = Get-HuduPasswordFolders -id $newPasswordFolder.id
            $newPasswordFolder.name               | Should -Be $retrievedPasswordFolder.name
            $newPasswordFolder.company_id         | Should -Be $retrievedPasswordFolder.company_id
            $newPasswordFolder.security           | Should -Be $retrievedPasswordFolder.security
            $newPasswordFolder.description        | Should -Be $retrievedPasswordFolder.description

            $updatedFolderName = "$(Get-RandomHexString -bytes $(get-random -Minimum 3 -Maximum 5)) $(Get-RandomHexString -bytes $(get-random -Minimum 6 -Maximum 9))"
            $updatedFolderDescription = "$(Get-RandomHexString), $(Get-RandomHexString) $(Get-RandomHexString) $(Get-RandomHexString)"
            Write-Host "updating password folder $($newPasswordFolder.name) ($i of $passwordFoldersToCreate) with alternate security, name, groups, and description -> $($updatedFolderName)"
            if ($passFolderRequest.AllowedGroups) {
                $updatedSecurity = 'specific'
                $updatedFolder = set-HuduPasswordFolder -id $newPasswordFolder.id -name $updatedFolderName -description $updatedFolderDescription -security $updatedSecurity
            } else {
                $updatedSecurity = 'all_users'
                $updatedGrops = $(if ($allgroups.count -gt 2) {$($allGroups | Get-Random -count $($allgroups.count -1))} else {@(0)})
                $updatedFolder = set-HuduPasswordFolder -id $newPasswordFolder.id -name $updatedFolderName -description $updatedFolderDescription -security $updatedSecurity -AllowedGroups $updatedGroups
            }
            $updatedFolder.name               | Should -Be $updatedFolderName
            $updatedFolder.security           | Should -Be $updatedSecurity
            $updatedFolder.description        | Should -Be $updatedFolderDescription

            Write-Host "Properties set and changed as expected for folder $i of $passwordFoldersToCreate; Deleting."
            remove-HuduPasswordFolder -id $updatedFolder.id

        }

    }
}
