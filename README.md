This is an unofficial powershell module to allow access to the Hudu API. I am not associated with Hudu other than as a customer.

Currently the API is missing some filtering options so I have had to implement them locally. This means especially the Get-HuduAssets command is very slow as no matter which options you specify it will have to download every asset and then filter it. I have a ticket with support to hopefully resolve this so I can fix it in a future version.

The filter options on get commands are all optional.

For more information on what Hudu provides and expects you can look at https://your.hudu.domain/developer/1.0/

Installation:

    install-module HuduAPI

Usage:

After installing the module you will need to get an api key from https://your.hudu.domain/admin/api_keys

    New-HuduAPIKey "YourKey"

    New-HuduBaseURL "https://your.hudu.domain"

Currently implemented commands are:

    New-HuduAPIKey
 
    Get-HuduAPIKey
 
    Remove-HuduAPIKey
 
    New-HuduBaseURL
 
    Get-HuduBaseURL
 
    Remove-HuduBaseURL
 
    Get-HuduAssets -name "Computer-01" -id 1 -assetlayoutid 1 -companyid 1 
 
    Get-HuduCompanies -name "Example Co" -phonenumber "0123456789" -website "https://example.com" -city "Town" -state "State" -id_in_integration "1234"
 
    Get-HuduAssetLayouts -name "People" -layoutid 1
    
    New-HuduAssetLayout -name "People" -icon "fas fa-retweet" -color "#fe9620" -icon_color "#ffffff" -include_passwords $false -include_photos $false -include_comments $false -include_files $false -fields $fields
    $fields = @(
		@{
			label = 'Plan Name'
			field_type = 'Text'
			position = 1
		},
		@{
			label = 'Computer Name'
			field_type = 'Text'
			position = 2
		}
 
    Get-HuduWebsites -name "https://example.com" -websiteid 1
 
    New-HuduWebsite -name "https://example.com" -companyid 1 -notes "Main website" -paused "false" -disabledns "false" -disablessl "false" -disablewhois "false" 

name and companyid are manditory for New-HuduWebsite

    Set-HuduMagicDash -title "My Dash" -company_name "Example Company" -message "Example message" -icon "fas fa-circle" -image_url "https://example.com/example.png" -content_link "https://example.com" -content "<p> This can be html or text and reveals when clicked</p>" -shade "success"

title, message and company_name are mandatory. You can only use one of icon or image_url. You can only use one of content_link or content

    Remove-HuduMagicDash -title "My Dash" -company_name "Example Company" -id 1

You can either user id or you can use title and company_name together


Get-HuduAssetLayoutFieldID
New-HuduAsset
Set-HuduAsset
Get-HuduArticles
New-HuduArticle
Set-HuduArticle
