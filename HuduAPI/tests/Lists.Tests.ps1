# Tests/Lists.Tests.ps1

Context "Hudu Lists Integration Tests" {

    BeforeEach {
        $HUDU_API_KEY  = $env:HUDU_API_KEY  ?? "$(Read-Host 'Enter Hudu API Key')"
        $HUDU_BASE_URL = $env:HUDU_BASE_URL ?? "$(Read-Host 'Enter Hudu Base URL')"

        New-HuduBaseURL $HUDU_BASE_URL
        New-HuduApiKey $HUDU_API_KEY

        Write-Host "Setting up test for Lists endpoint... Hudu version: $((Get-HuduAppInfo).version)"
    }

    It "Creates, retrieves, updates, and deletes a List" {
        # 1.1 Create List
        $listName = "IntegrationTestList-$(Get-Random)"
        $itemNames = @("Alpha", "Beta", "Gamma")

        $createdList = New-HuduList -Name $listName -Items $itemNames
        $createdList | Should -Not -BeNullOrEmpty
        $createdList.name | Should -Be $listName
        $createdList.list_items.Count | Should -Be 3

        Write-Host "Created list: $($createdList | ConvertTo-Json -Depth 5)"

        # 1.2 Retrieve by ID
        $fetchedById = Get-HuduLists -Id $createdList.id
        $fetchedById | Should -Not -BeNullOrEmpty
        $fetchedById.name | Should -Be $listName
        $fetchedById.list_items.Count | Should -Be 3

        # 1.3 Retrieve by Name
        $fetchedByName = Get-HuduLists -Name $listName
        $fetchedByName | Should -Not -BeNullOrEmpty
        $fetchedByName.name | Should -Be $listName

        # 1.4 Update List
        $updatedName = "$listName-Updated"
        $existingItems = $createdList.list_items

        $updatedList = Set-HuduList -Id $createdList.id -Name $updatedName -ListItems @(
            @{ id = $existingItems[0].id; name = "Delta" },
            @{ name = "Epsilon" },
            @{ id = $existingItems[1].id; _destroy = $true }
        )

        $updatedList | Should -Not -BeNullOrEmpty
        $updatedList.name | Should -Be $updatedName
        ($updatedList.list_items.name -contains "Delta") | Should -Be $true
        ($updatedList.list_items.name -contains "Epsilon") | Should -Be $true
        ($updatedList.list_items.name -contains "Beta") | Should -Be $false

        # 1.5 Delete List
        Remove-HuduList -Id $createdList.id
        $deleted = Get-HuduLists -Id $createdList.id
        $deleted | Should -BeNullOrEmpty
    }
}
