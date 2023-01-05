function Set-HuduMagicDash {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Title,
		[Alias("company_name")]
		[Parameter(Mandatory = $true)]
		[String]$CompanyName,
		[Parameter(Mandatory = $true)]
		[String]$Message,
		[String]$Icon = '',
		[Alias("image_url")]
		[String]$ImageURL = '',
		[Alias("content_link")]
		[String]$ContentLink = '',
		[String]$Content = '',
		[String]$Shade = ''
	)
	
	if ($Icon -and $ImageURL) {
		write-error ("You can only use one of icon or image URL")
		exit 1
	}
	
	if ($content_link -and $content) {
		write-error ("You can only use one of content or content_link")
		exit 1
	}
	
	$MagicDash = [ordered]@{}
	
	if ($Title) {
		$MagicDash.add('title', $Title)
	}
	
	if ($CompanyName) {
		$MagicDash.add('company_name', $CompanyName)
	}
	
	if ($Message) {
		$MagicDash.add('message', $Message)
	}
	
	if ($Icon) {
		$MagicDash.add('icon', $Icon)
	}
	
	if ($ImageURL) {
		$MagicDash.add('image_url', $ImageURL)
	}
	
	if ($ContentLink) {
		$MagicDash.add('content_link', $ContentLink)
	}
	
	if ($Content) {
		$MagicDash.add('content', $Content)
	}
	
	if ($Shade) {
		$MagicDash.add('shade', $Shade)
	}
	
	$JSON = $MagicDash | convertto-json
	
	$Response = Invoke-HuduRequest -Method post -Resource "/api/v1/magic_dash" -body $JSON
	
	$Response
}