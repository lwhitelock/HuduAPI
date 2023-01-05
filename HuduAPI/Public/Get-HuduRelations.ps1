function Get-HuduRelations {
	Param ()
	$ResourceFilter = ''

	if ($CompanyId) {
		$ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
	}

	if ($Title) {
		$ResourceFilter = "$($ResourceFilter)&title=$($Title)"
	}
	
	$i = 1;
	$AllRelations = do {
		$Relations = Invoke-HuduRequest -Method get -Resource "/api/v1/relations?page=$i&page_size=1000$($ResourceFilter)"
		$i++
		$Relations.relations
	} while ($Relations.relations.count % 1000 -eq 0 -and $Relations.relations.count -ne 0)
		
	return $AllRelations
	
}