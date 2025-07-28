function New-HuduProcedureTask {
    <#
    .SYNOPSIS
    Create a new procedure task

    .DESCRIPTION
    Creates a new task associated with a procedure.

    .PARAMETER Name
    Name of the task

    .PARAMETER ProcedureId
    ID of the procedure to attach the task to

    .PARAMETER Description
    Optional task description

    .PARAMETER Priority
    Optional priority level (e.g., "unsure", "low", "normal", "high", "urgent")

    .PARAMETER UserId
    Optional single user assignment

    .PARAMETER AssignedUsers
    Optional array of user IDs to assign

    .PARAMETER DueDate
    Optional due date (YYYY-MM-DD)

    .PARAMETER Position
    Optional ordering position

    .EXAMPLE
    New-HuduProcedureTask -Name "Initial Review" -ProcedureId 123 -Priority "high"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [int]$ProcedureId,
        [string]$Description,
        [ValidateSet("unsure", "low", "normal", "high", "urgent")]
        [string]$Priority,
        [int]$UserId,
        [int[]]$AssignedUsers,
        [string]$DueDate,
        [int]$Position
    )

    $task = @{
        name         = $Name
        procedure_id = $ProcedureId
    }

    if ($Description)    { $task.description     = $Description }
    if ($Priority)       { $task.priority        = $Priority }
    if ($UserId)         { $task.user_id         = $UserId }
    if ($AssignedUsers)  { $task.assigned_users  = $AssignedUsers }
    if ($DueDate)        { $task.due_date        = $DueDate }
    if ($Position)       { $task.position        = $Position }

    $payload = @{ procedure_task = $task } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/procedure_tasks" -Body $payload
        return $res.procedure_task
    } catch {
        Write-Warning "Failed to create procedure task '$Name'"
        return $null
    }
}
