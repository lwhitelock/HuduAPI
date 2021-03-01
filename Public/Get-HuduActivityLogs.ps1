function Get-HuduActivityLogs{
	Param (
		[Int]$user_id ='',
		[String]$user_email ='',
		[Int]$resource_id ='',
		[String]$resource_type ='',
		[String]$action_message ='',
        [DateTime]$start_date,
        [DateTime]$end_date
		
	)
	
	$resourcefilter = ''
	
	if ($user_id) {
		$resourcefilter = "$($resourcefilter)&user_id=$($user_id)"
	}
	
	if ($user_email) {
		$resourcefilter = "$($resourcefilter)&user_email=$($user_email)"
	}
	
	if ($resource_id) {
		$resourcefilter = "$($resourcefilter)&resource_id=$($resource_id)"
	}
	
	if ($resource_type) {
		$resourcefilter = "$($resourcefilter)&city=$($resource_type)"
	}
	
	if ($action_message) {
		$resourcefilter = "$($resourcefilter)&action_message=$($action_message)"
	}

	if ($start_date) {
		$iso8601date = $start_date.ToString("o");
        $resourcefilter = "$($resourcefilter)&start_date=$($iso8601date)"
    }
	
	$i = 1;
		
    $AllActivity = do {
		$Activity = Invoke-HuduRequest -Method get -Resource "/api/v1/activity_logs?page=$i&page_size=1000$($resourcefilter)"
		$i++
		$Activity
	} while ($Activity.count % 1000 -eq 0 -and $Activity.count -ne 0)
		 
    
    if ($end_date) {
        $AllActivity = $AllActivity | where-object {$([DateTime]::Parse($_.created_at)) -le $end_date}
    }


	return $AllActivity
	
}