function Get-HuduProcesses {
	[CmdletBinding()]
	Param (
		[Int]$Id = '',
		[Alias("company_id")]
		[Int]$CompanyId = '',
		[String]$Name = ''
	
	)
	
	if ($Id) {
		$Process = Invoke-HuduRequest -Method get -Resource "/api/v1/procedures/$id"
		return $Process
	} else {

		$ResourceFilter = ''

		if ($CompanyId) {
			$ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
		}

		if ($Name) {
			$ResourceFilter = "$($ResourceFilter)&name=$($Name)"
		}
	
		$i = 1;
		$AllProcesses = do {
			$Processes = Invoke-HuduRequest -Method get -Resource "/api/v1/procedures?page=$i&page_size=1000$($ResourceFilter)"
			$i++
			$Processes.procedures
		} while ($Processes.procedures.count % 1000 -eq 0 -and $Processes.procedures.count -ne 0)
		
	
		return $AllProcesses
	
	}
}