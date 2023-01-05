function Get-HuduActivityLogs {
	[CmdletBinding()]
	Param (
		[Alias("user_id")]
		[Int]$UserId = '',
		[Alias("user_email")]
		[String]$UserEmail = '',
		[Alias("resource_id")]
		[Int]$ResourceId = '',
		[Alias("resource_type")]
		[String]$ResourceType = '',
		[Alias("action_message")]
		[String]$ActionMessage = '',
		[Alias("start_date")]
		[DateTime]$StartDate,
		[Alias("end_date")]
		[DateTime]$EndDate	
	)
	
	$ResourceFilter = ''
	
	if ($UserId) {
		$ResourceFilter = "$($ResourceFilter)&user_id=$($UserId)"
	}
	
	if ($UserEmail) {
		$ResourceFilter = "$($ResourceFilter)&user_email=$($UserEmail)"
	}
	
	if ($ResourceId) {
		$ResourceFilter = "$($ResourceFilter)&resource_id=$($ResourceId)"
	}
	
	if ($ResourceType) {
		$ResourceFilter = "$($ResourceFilter)&resource_type=$($ResourceType)"
	}
	
	if ($ActionMessage) {
		$ResourceFilter = "$($ResourceFilter)&action_message=$($ActionMessage)"
	}

	if ($StartDate) {
		$ISO8601Date = $StartDate.ToString("o");
		$ResourceFilter = "$($ResourceFilter)&start_date=$($ISO8601Date)"
	}
	
	$i = 1;
		
	$AllActivity = do {
		$Activity = Invoke-HuduRequest -Method get -Resource "/api/v1/activity_logs?page=$i&page_size=1000$($ResourceFilter)"
		$i++
		$Activity
	} while ($Activity.count % 1000 -eq 0 -and $Activity.count -ne 0)
		 
    
	if ($EndDate) {
		$AllActivity = $AllActivity | where-object { $([DateTime]::Parse($_.created_at)) -le $EndDate }
	}

	return $AllActivity
	
}