
## Release Notes
https://github.com/lwhitelock/HuduAPI/releases

## Installation

    install-module HuduAPI

## Implemented Commands
		New-HuduAPIKey
		Get-HuduAPIKey
		Remove-HuduAPIKey
		New-HuduBaseURL
		Get-HuduBaseURL
		Remove-HuduBaseURL
		Get-HuduAssets
		Invoke-HuduRequest
		Get-HuduCompanies
		Get-HuduAssetLayouts
		Get-HuduWebsites
		New-HuduWebsite
		Set-HuduMagicDash
		Remove-HuduMagicDash
		New-HuduAssetLayout
		Get-HuduAssetLayoutFieldID
		New-HuduAsset
		Set-HuduAsset
		Get-HuduArticles
		New-HuduArticle
		Set-HuduArticle
		Get-HuduPasswords
		Set-HuduPassword
		New-HuduPassword
		Remove-HuduPassword
		Get-HuduActivityLogs
		Set-HuduAssetLayout
		Get-HuduCard
		New-HuduCompany
		Remove-HuduArticle
		Remove-HuduAsset
		Remove-HuduPassword
		Remove-HuduWebsite
		Set-HuduArticleArchive
		Set-HuduAssetArchive
		Set-HuduAssetLayout
		Set-HuduCompany
		Set-HuduCompanyArchive
		Set-HuduPasswordArchive
		Set-HuduWebsite
		Get-HuduAppInfo
		Get-HuduExpirations

## Usage
For examples please see my blog: https://mspp.io/category/hudu/ or this repository https://github.com/lwhitelock/HuduAutomation

After installing the module you will need to get an api key from https://your.hudu.domain/admin/api_keys

    New-HuduAPIKey "YourKey"

    New-HuduBaseURL "https://your.hudu.domain"
 
    Get-HuduAssets -name "Computer-01" -id 1 -assetlayoutid 1 -companyid 1 
    
    New-HuduAsset -name "Computer-01 - Backup Plan 1" -company_id 10 -asset_layout_id 2 -fields $fields
    $fields = @(
		@{
			plan_name = "Backup Plan1"
		},
		@{
			computer_name = "Computer-01"
		})
    
    Set-HuduAsset -name "Computer-01 - Backup Plan 1" -company_id 10 -asset_layout_id 2 -fields $fields -asset_id 100
 
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
		})
	
 
    Get-HuduAssetLayoutFieldID -name "Plan Name" -asset_layout_id 2
 	
    Get-HuduWebsites -name "https://example.com" -websiteid 1
 
    New-HuduWebsite -name "https://example.com" -companyid 1 -notes "Main website" -paused "false" -disabledns "false" -disablessl "false" -disablewhois "false" 

name and companyid are manditory for New-HuduWebsite

    Set-HuduMagicDash -title "My Dash" -company_name "Example Company" -message "Example message" -icon "fas fa-circle" -image_url "https://example.com/example.png" -content_link "https://example.com" -content "<p> This can be html or text and reveals when clicked</p>" -shade "success"

title, message and company_name are mandatory. You can only use one of icon or image_url. You can only use one of content_link or content

    Remove-HuduMagicDash -title "My Dash" -company_name "Example Company" -id 1

You can either user id or you can use title and company_name together


    Get-HuduArticles -name "Test" -id 10 -company_id 20
    
    New-HuduArticle -name "Test" -content "<p>Html content of article</p>" -folder_id 100 -company_id 20
Name and Content are mandatory, folder_id and company_id are optional. Setting no company ID adds to the global KB
    
    Set-HuduArticle -name "Test" -content "<p>Html content of article</p>" -folder_id 100 -company_id 20 -article_id 10
