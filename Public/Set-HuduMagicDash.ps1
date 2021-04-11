function Set-HuduMagicDash {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$title ='',
		[Parameter(Mandatory=$true)]
		[String]$company_name='',
		[Parameter(Mandatory=$true)]
		[String]$message='',
		[String]$icon='',
		[String]$image_url='',
		[String]$content_link='',
		[String]$content='',
		[String]$shade=''
	)
	
	if ($icon -and $image_url){
		write-error ("You can only use one of icon or image_url")
		exit 1
	}
	
	if ($content_link -and $content){
		write-error ("You can only use one of content or content_link")
		exit 1
	}
	
	$magicdash = [ordered]@{}
	
	if ($title) {
		$magicdash.add('title',$title)
	}
	
	if ($company_name) {
		$magicdash.add('company_name',$company_name)
	}
	
	if ($message) {
		$magicdash.add('message',$message)
	}
	
	if ($icon) {
		$magicdash.add('icon',$icon)
	}
	
	if ($image_url) {
		$magicdash.add('image_url',$image_url)
	}
	
	if ($content_link) {
		$magicdash.add('content_link',$content_link)
	}
	
	if ($content) {
		$magicdash.add('content',$content)
	}
	
	if ($shade) {
		$magicdash.add('shade',$shade)
	}
	
	$json = $magicdash | convertto-json
	
	$response = Invoke-HuduRequest -Method post -Resource "/api/v1/magic_dash" -body $json
	
	$response
}