function Get-HuduActivityLogs {
    <#
    .SYNOPSIS
    Get activity logs for account

    .DESCRIPTION
    Calls Hudu API to retrieve activity logs with filters

    .PARAMETER UserId
    Filter logs by user_id

    .PARAMETER UserEmail
    Filter logs by email address

    .PARAMETER ResourceId
    Filter logs by resource id. Must be coupled with resource_type

    .PARAMETER ResourceType
    Filter logs by resource type (Asset, AssetPassword, Company, Article, etc.). Must be coupled with resource_id

    .PARAMETER ActionMessage
    Filter logs by action

    .PARAMETER StartDate
    Filter logs by start date. Converts string to ISO 8601 format

    .PARAMETER EndDate
    Filter logs by end date, should be coupled with start date to limit results

    .EXAMPLE
    Get-HuduActivityLogs -StartDate 2023-02-01

    #>
    [CmdletBinding()]
    Param (
        [Alias('user_id')]
        [Int]$UserId = '',
        [Alias('user_email')]
        [String]$UserEmail = '',
        [Alias('resource_id')]
        [Int]$ResourceId = '',
        [Alias('resource_type')]
        [String]$ResourceType = '',
        [Alias('action_message')]
        [String]$ActionMessage = '',
        [Alias('start_date')]
        [DateTime]$StartDate,
        [Alias('end_date')]
        [DateTime]$EndDate
    )

    $Params = @{}

    if ($UserId) { $Params.user_id = $UserId }
    if ($UserEmail) { $Params.user_email = $UserEmail }
    if ($ResourceId) { $Params.resource_id = $ResourceId }
    if ($ResourceType) { $Params.resource_type = $ResourceType }
    if ($ActionMessage) { $Params.action_message = $ActionMessage }
    if ($StartDate) {
        $ISO8601Date = $StartDate.ToString('o');
        $Params.start_date = $ISO8601Date
    }

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/activity_logs'
        Params   = $Params
    }

    $AllActivity = Invoke-HuduRequestPaginated -HuduRequest $HuduRequest

    if ($EndDate) {
        $AllActivity = $AllActivity | Where-Object { $([DateTime]::Parse($_.created_at)) -le $EndDate }
    }

    return $AllActivity
}
