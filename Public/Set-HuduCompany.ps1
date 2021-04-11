function Set-HuduCompany {
	Param (
        [Parameter(Mandatory=$true)]
        [Int]$id='',
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[String]$nickname ='',
        [String]$address_line_1 ='',
        [String]$address_line_2 ='',
        [String]$city ='',
        [String]$state ='',
        [String]$zip ='',
        [String]$country_name ='',
        [String]$phone_number ='',
        [String]$fax_number ='',
        [String]$website ='',
        [String]$id_number ='',
        [String]$notes =''
	)
	

	$company = [ordered]@{company = [ordered]@{}}
	
	$company.company.add('name',$name)
	$company.company.add('nickname',$nickname)
	$company.company.add('address_line_1',$address_line_1)
    $company.company.add('address_line_2',$address_line_2)
    $company.company.add('city',$city)
    $company.company.add('state',$state)
    $company.company.add('zip',$zip)
    $company.company.add('country_name',$country_name)
    $company.company.add('phone_number',$phone_number)
    $company.company.add('fax_number',$fax_number)
    $company.company.add('website',$website)
    $company.company.add('id_number',$id_number)
    $company.company.add('notes',$notes)
	
	$json = $company | convertto-json -Depth 10
	
	$response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$id" -body $json
	
	$response
	
	
}