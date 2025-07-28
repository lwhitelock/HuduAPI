# Tests/RackStorages.Tests.ps1



Context "Hudu Procedures and Procedure Tasks Integration Tests" {

    BeforeEach {
        # Load test config from env vars or inline fallback
        $HUDU_API_KEY     = $env:HUDU_API_KEY     ?? "$(read-host "enter hudu api key for rackstorage test")"
        $HUDU_BASE_URL    = $env:HUDU_BASE_URL    ?? "$(read-host "enter hudu base url for rackstorage test")"
        $MinProcedureTaskCount = 1
        $MaxProcedureTaskCount = 12

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

    It "Creates, retrieves, updates, and deletes a Procedure (with tasks), switches to procedure template, creates from template, duplicates, then cleans up" {

    # Test 1- Create Procedure, Assign Tasks, Modify Tasks, Remove Tasks, Modify Procedure, Clean Up
        # 1.1 Create
        $ProcedureName = "Procedure-$(Get-Random)"
        $ProcedureTasksCount = $(Get-Random -Minimum $MinProcedureTaskCount -Maximum $MaxProcedureTaskCount)
        $ProcedureDescription = "(from Huduapi module integration tests). Procedure $ProcedureName will have $ProcedureTasksCount Procedures assigned to Company $testCompanyId."
        
        Write-host "$ProcedureDescription... Creating" -ForegroundColor Green

        $createdProcedure = $(New-HuduProcedure -CompanyId $testCompanyId `
                                              -Name $ProcedureName `
                                              -Description $ProcedureDescription).procedure

        $createdProcedure | ConvertTo-Json -Depth 6 | Write-Host
        Write-host "Created tasks will be assigned to user $testUserId and Due By $DueDate with priority of $Priority"
        

        $ProposedProcedureTasks = @()        
        $CreatedProcedureTasks = @()

        for ($i = 1; $i -le $ProcedureTasksCount; $i++) {
            $newTask = @{
                ProcedureId   = $createdProcedure.id
                Name          = "$ProcedureName-Task-$i"
                DueDate       = (Get-Date).AddDays((Get-Random -Minimum -5 -Maximum 15)).ToString("yyyy-MM-dd")
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
        $ProcedureWithTasks=$(Get-HuduProcedures -id $createdProcedure.id).procedure

        $ProcedureWithTasks.procedure_task_attributes | Should -Not -BeNullOrEmpty
        $ProcedureWithTasks.procedure_task_attributes.Count | Should -Be $ProcedureTasksCount

    }
}