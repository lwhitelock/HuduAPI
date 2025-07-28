function Set-HuduProcedureTask {
    <#
    .SYNOPSIS
    Update an existing procedure task

    .DESCRIPTION
    Updates attributes of a procedure task.

    .PARAMETER Id
    ID of the task to update

    .PARAMETER Name
    New name

    .PARAMETER Description
    New description

    .PARAMETER Completed
    Mark task as completed/uncompleted

    .PARAMETER ProcedureId
    New procedure ID to reassign task

    .PARAMETER Position
    Task position in procedure

    .PARAMETER UserId
    Single user assignment

    .PARAMETER DueDate
    Due date (YYYY-MM-DD)

    .PARAMETER Priority
    Task priority

    .PARAMETER AssignedUsers
    Array of user IDs

    .EXAMPLE
    Set-HuduProcedureTask -Id 101 -Completed $true
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [int]$Id,
        [string]$Name,
        [string]$Description,
        [bool]$Completed,
        [int]$ProcedureId,
        [int]$Position,
        [int]$UserId,
        [string]$DueDate,
        [ValidateSet("unsure", "low", "normal", "high", "urgent")]
        [string]$Priority,
        [int[]]$AssignedUsers
    )

    $task = @{}
    if ($Name)          { $task.name            = $Name }
    if ($Description)   { $task.description     = $Description }
    if ($Completed -ne $null) { $task.completed = $Completed }
    if ($ProcedureId)   { $task.procedure_id    = $ProcedureId }
    if ($Position)      { $task.position        = $Position }
    if ($UserId)        { $task.user_id         = $UserId }
    if ($DueDate)       { $task.due_date        = $DueDate }
    if ($Priority)      { $task.priority        = $Priority }
    if ($AssignedUsers) { $task.assigned_users  = $AssignedUsers }

    $payload = @{ procedure_task = $task } | ConvertTo-Json -Depth 10

    try {
        $res = Invoke-HuduRequest -Method PUT -Resource "/api/v1/procedure_tasks/$Id" -Body $payload
        return $res.procedure_task
    } catch {
        Write-Warning "Failed to update procedure task ID $Id"
        return $null
    }
}
