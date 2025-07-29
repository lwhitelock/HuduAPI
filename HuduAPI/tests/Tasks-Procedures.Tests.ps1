# Tests/RackStorages.Tests.ps1



Context "Hudu Procedures and Procedure Tasks Integration Tests" {

    BeforeEach {
        # Load test config from env vars or inline fallback
        $HUDU_API_KEY     = $env:HUDU_API_KEY     ?? "$(read-host "enter hudu api key for rackstorage test")"
        $HUDU_BASE_URL    = $env:HUDU_BASE_URL    ?? "$(read-host "enter hudu base url for rackstorage test")"
        $MinProcedureTaskCount = 1
        $MaxProcedureTaskCount = 36

        new-hudubaseurl $hudu_base_url
        new-huduapikey $hudu_api_key
        Write-Host "setting up test for Procedures and Procedure Tasks, Hudu version $((Get-HuduAppInfo).version)... Prerequisites:`n1: test environment must have a predefined Company, Asset, and User."
        $priorities = @("unsure", "low", "normal", "high", "urgent")
        $testCompanyId        = [int]$env:HUDU_TEST_COMPANY_ID ?? $(Get-HuduCompanies | Select-Object -First 1).id
        $testUserId           = [int]$env:HUDU_TEST_USER_ID ?? $(Get-HuduUsers | Select-Object -First 1).id

        if (-not $testCompanyId) {
            throw "Missing required test environment variables (HUDU_TEST_COMPANY_ID, etc.)"
        }
    }

    It "Creates and checks a Procedure, adds and checks tasks, modifies and checks tasks, cleans up" {

    # Test 1- Create Procedure, Assign Tasks, Modify Tasks, Remove Tasks, Modify Procedure, Clean Up
        # 1.1 Create Procedure (parent object)
        $ProcedureName = "Procedure-$(Get-Random)"
        $ProcedureTasksCount = $(Get-Random -Minimum $MinProcedureTaskCount -Maximum $MaxProcedureTaskCount)
        $ProcedureDescription = "Procedure $ProcedureName with $ProcedureTasksCount assigned procedures for Company $testCompanyId."
        Write-host "$ProcedureDescription... Creating now!" -ForegroundColor Green
        $createdProcedure = $(New-HuduProcedure -CompanyId $testCompanyId `
                                              -Name $ProcedureName `
                                              -Description $ProcedureDescription).procedure

        $createdProcedure.name | Should -Be $ProcedureName
        $createdProcedure.description | Should -Be $ProcedureDescription
        Write-host "Created New Procedure $($createdProcedure.name)... Procedure tasks will be assigned to user $testUserId with random Due date and Priority"
        
        # 1.2 Create Procedure Tasks under this procedure
        $ProposedProcedureTasks = @()        
        $CreatedProcedureTasks = @()

        for ($i = 1; $i -le $ProcedureTasksCount; $i++) {
            $newTask = @{
                ProcedureId   = $createdProcedure.id
                Name          = "$ProcedureName-Task-$i"
                DueDate       = (Get-Date).AddHours((Get-Random -Minimum -5 -Maximum 15)).AddMonths((Get-Random -Minimum -5 -Maximum 15)).AddDays((Get-Random -Minimum -5 -Maximum 15)).ToString("yyyy-MM-dd")
                Description   = "Task $i of $ProcedureTasksCount for $ProcedureName"
                Priority      = $priorities | Get-Random
                UserId        = $testUserId
                AssignedUsers = @($testUserId)
            }

            $ProposedProcedureTasks += $newTask

            Write-Host "Creating Procedure Task $i → Due: $($newTask.DueDate), Priority: $($newTask.Priority)"

            try {
                $CreatedProcedureTask = New-HuduProcedureTask @newTask
                $CreatedProcedureTasks += $CreatedProcedureTask
            } catch {
                Write-Error "Failed to create task $i... $_"
            }
        }

        # 1.3 Fetch / Check Tasks under this procedure
        $ProcedureWithTasks=$(Get-HuduProcedures -id $createdProcedure.id)
        $ProcedureWithTasks.name | Should -Be $ProcedureName
        $ProcedureWithTasks.description | Should -Be $ProcedureDescription        
        $ProcedureWithTasks.procedure_tasks_attributes | Should -Not -BeNullOrEmpty
        $ProcedureWithTasks.procedure_tasks_attributes.Count | Should -Be $ProcedureTasksCount
        $proceduresToCleanup = @(
            $ProcedureWithTasks.id 
        )

        # 1.4 Modify each task and validate expected results
        foreach ($task in $CreatedProcedureTasks) {
            $original = $original = Get-HuduProcedureTasks -Id $task.id
            $modifiedName = $(if ($(Get-Random -Minimum 0 -Maximum 1) -eq 0) {"A-$(Get-Random -Minimum 256 -Maximum 512)-$($original.Name)"} else {"Z-$($original.Name)$(Get-Random -Minimum 256 -Maximum 512)"})
            $newDueDate = (Get-Date).AddDays((Get-Random -Minimum 4 -Maximum 8))
            $newDueDateFormatted = $newDueDate.ToString("yyyy-MM-dd")
            $newPriority = $priorities | Get-Random
            $NewDescription = "ModifiedDescription-$(Get-Random -Minimum 0 -Maximum 9999) --- $($original.Description)"
            Write-Host "Modifying Procedure Task Name $($original.Name) → $modifiedName"
            Write-Host "Modifying Procedure Task Description $($original.description) → $NewDescription"
            Write-Host "Modifying Procedure Task Due Date $($OriginalDueDateObj) → $newDueDate"
            Write-Host "Modifying Procedure Task Priority $($original.priority) → $newPriority"
            Write-Host "Modifying Procedure Task [removing assigned users]"
            $updatedProcedureTask = $(Set-HuduProcedureTask -id $original.Id `
                                                   -DueDate $newDueDateFormatted `
                                                   -Name $modifiedName `
                                                   -Priority $newPriority `
                                                   -Description $NewDescription `
                                                   -AssignedUsers @())

            $updatedProcedureTask.name | Should -Not -Be $original.name
            $updatedProcedureTask.name | Should -Be $modifiedName
            $UpdatedDueDate = [datetime]::ParseExact($updatedProcedureTask.due_date, "yyyy-MM-dd", $null)

            $UpdatedDueDate | Should -Not -Be $OriginalDueDateObj
            $UpdatedDueDate.ToString("yyyy-MM-dd") | Should -Be $newDueDateFormatted

            $updatedProcedureTask.priority | Should -Be $newPriority

            $updatedProcedureTask.description | Should -Not -Be $original.description
            $updatedProcedureTask.description | Should -Be $NewDescription

            Write-Host "Modified Task $($updatedProcedureTask.Name) checks out, cleaning up"

            # 1.5 Clean-Up tasks
            Remove-HuduProcedureTask -id $updatedProcedureTask.id
        }
        # 1.6 Clean-Up procedures
        foreach ($procedureId in $proceduresToCleanup) {
            Remove-HuduProcedure -id $procedureId
        }
    }
It "Creates a Procedure (with tasks), switches to procedure template, creates from template, kicks off against asset, then cleans up" {

    # Test 2- Create Procedure, Assign Tasks, Modify Tasks, Remove Tasks, Modify Procedure, Clean Up
        # 2.1 Create Procedure (parent object)
        $ProcedureName = "Procedure-$(Get-Random)"
        $ProcedureTasksCount = $(Get-Random -Minimum $MinProcedureTaskCount -Maximum 6)
        $ProcedureDescription = "Procedure $ProcedureName with $ProcedureTasksCount assigned procedures for Company $testCompanyId."
        Write-host "$ProcedureDescription... Creating now!" -ForegroundColor Green
        $createdProcedure = $(New-HuduProcedure -CompanyId $testCompanyId `
                                              -Name $ProcedureName `
                                              -Description $ProcedureDescription).procedure
        $createdProcedure | ConvertTo-Json -Depth 6 | Write-Host
        Write-host "Created New Procedure $($createdProcedure.name)... Procedure tasks will be assigned to user $testUserId with random Due date and Priority"
        
        # 2.2 Create Procedure Tasks under this procedure
        $ProposedProcedureTasks = @()        
        $CreatedProcedureTasks = @()

        for ($i = 1; $i -le $ProcedureTasksCount; $i++) {
            $newTask = @{
                ProcedureId   = $createdProcedure.id
                Name          = "$ProcedureName-Task-$i"
                DueDate       = (Get-Date).AddHours((Get-Random -Minimum -5 -Maximum 15)).AddMonths((Get-Random -Minimum -5 -Maximum 15)).AddDays((Get-Random -Minimum -5 -Maximum 15)).ToString("yyyy-MM-dd")
                Description   = "Task $i of $ProcedureTasksCount for $ProcedureName"
                Priority      = $priorities | Get-Random
                UserId        = $testUserId
                AssignedUsers = @($testUserId)
            }

            $ProposedProcedureTasks += $newTask

            Write-Host "Creating Procedure Task $i → Due: $($newTask.DueDate), Priority: $($newTask.Priority)"

            try {
                $CreatedProcedureTask = New-HuduProcedureTask @newTask
                $CreatedProcedureTasks += $CreatedProcedureTask
            } catch {
                Write-Error "Failed to create task $i... $_"
            }
        }
        # 2.3 Rename procedure and check name
        $updatedProcedure = Set-HuduProcedure -Id $createdProcedure.id -Name "newname-$($createdProcedure.Name)" -CompanyId $testCompanyId
        $updatedProcedure.name | Should -Not -Be $ProcedureName
        $updatedProcedure.name | Should -Be "newname-$($createdProcedure.Name)"
        $updatedProcedure.id | Should -Be $createdProcedure.id


        # 2.4 Create a template version of this procedure to copy template from procedure
        $createdTemplateProcedure = $(New-HuduProcedure -CompanyId $testCompanyId `
                                              -Name "Template-$ProcedureName" `
                                              -Description $ProcedureDescription `
                                              -CompanyTemplate $true).procedure

        Write-Host "Created process template: $($createdTemplateProcedure.id)" -ForegroundColor Green

        # 2.5 Create copy from template of procedure
        $createdProcedureFromTemplate = $(New-HuduProcedureFromTemplate -id $createdTemplateProcedure.id -CompanyId $testCompanyId)
        Write-Host "Created process fron template $($createdProcedureFromTemplate.id)" -ForegroundColor Green

        # 2.6 Create gloabl template of procedure
        $createdGlobalProcedureFromTemplate = $(New-HuduProcedureFromTemplate -id $createdTemplateProcedure.id)
        Write-Host "Created global process template $($createdGlobalProcedureFromTemplate.id)" -ForegroundColor Green

        # 2.7 Kick off a procedure against first asset of test company
        $target_asset=$(Get-HuduAssets -CompanyId $testCompanyId | Select-Object -First 1).asset
        $kickoff = Start-HuduProcedure -id $createdProcedureFromTemplate.id -AssetId $target_asset.id -name "kickoff -$($target_asset.name)"
        $kickoff | Get-Member
        Write-Host "Kicked off new process $($kickoff.id) against asset $($target_asset.id)" -ForegroundColor Green

        $proceduresToCleanup = @(
           $createdGlobalProcedureFromTemplate.id, $createdProcedureFromTemplate.id, $createdTemplateProcedure.id,  $createdProcedure.id 
        )
        # 2.8 Clean up procedures

        foreach ($procedureId in $proceduresToCleanup) {
            Remove-HuduProcedure -id $procedureId
        }
    }

}

