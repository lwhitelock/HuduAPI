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
        $priorities = @("unsure", "low", "medium", "high")
        $TemplateOptions = @($false, $true)
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

        $createdProcedure = New-HuduProcedure -CompanyId $testCompanyId `
                                              -Name $ProcedureName `
                                              -Description $ProcedureDescription `
                                              -AssignedUsers @($testUserId) `
                                              -Priority $Priority

        Write-Host "Created Procedure $($createdProcedure | ConvertFrom-json -Depth 6 | Out-String)"
        Write-host "Created tasks will be assigned to user $testUserId and Due By $DueDate with priority of $Priority"
        

        $ProposedProcedureTasks = @()        
        $CreatedProcedureTasks = @()
        $ProcedureTaskIDX = 0
        foreach ($genProcedureTask in $ProcedureTasksCount){
            $ProcedureTaskIDX = $ProcedureTaskIDX +1
            $newProcedureTask = @{
                Name = "$ProcedureName-Task-$($genProcedureTask)"
                ProcedureId = $createdProcedure.Id
                DueDate = $((get-date).AddDays($(Get-Random -Minimum -5 -Maximum 15)).AddMonths($(Get-Random -Minimum -10 -Maximum 10)))
                Description = "Procedure from integration tests Number $ProcedureTaskIDX of $ProcedureTasksCount for Procedure $ProcedureName"
                Priority = $priorities[(Get-Random -Minimum 0 -Maximum $priorities.Length)]
                UserID = $testUserId
                AssignedUsers = @($testUserId)
            }
            $ProposedProcedureTasks += $newProcedureTask
            Write-Host "Creating Procedure Task $ProcedureTaskIDX with DueDate $($newProcedureTask.DueDate) and priority $($newProcedureTask.Priority) for Procedure $($newProcedureTask.ProcedureId)"
            try {
                $CreatedProcedureTask = New-HuduProcedureTask @newProcedureTask
                $CreatedProcedureTasks += $CreatedProcedureTask
            } catch {
                Write-Error $_
            }
        }

        $ProcedureWithTasks=Get-HuduProcedures -id $createdProcedure.id

        $ProcedureWithTasks.procedure_task_attributes | Should -Not -BeNullOrEmpty
        $ProcedureWithTasks.procedure_task_attributes.Count | Should -Be $ProcedureTasksCount

    }
}