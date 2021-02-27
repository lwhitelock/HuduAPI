This is an unofficial powershell module to allow access to the Hudu API. I am not associated with Hudu other than as a customer.

NOTE2:
I have talked to Hudu and it wasn't supposed to be a breaking change. I think I am going to leave it in the powershell module to work this way, as supporting a -fields and a -custom_fields will just confuse people going forwards. I can't see any reason to keep the legacy method over the new one and it is a relatively quick fix to swap over an existing script.

NOTE:
Hudu have updated their API with some better filtering options. They have also updated their Asset creation API with breaking changes. If you install/update Hudu after 26th of Feb you need to use version 1.11 of the powershell module or above. If you are using a version prior to that you will need to use version 1.10.

The main change is you now need to provide fields to an asset as:

"field_name": "value"

Where field name is the asset layout field name in lower case with spaces converted to _

In the prior version you needed to provide

"asset_layout_field_id": 1

"value": "value"

I have updated my MSP360 script in Github with the changes to work with the latest version. This version is much faster due to the new filtering options and shows the new asset field style needed:

https://github.com/lwhitelock/HuduAutomation/blob/main/Hudu-M365-Sync.ps1


The filter options on get commands are all optional.

For more information on what Hudu provides and expects you can look at https://your.hudu.domain/developer/1.0/

For examples please see my blog: https://mspp.io/category/hudu/ or this repository https://github.com/lwhitelock/HuduAutomation

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
    
    New-HuduAsset -name "Computer-01 - Backup Plan 1" -company_id 10 -asset_layout_id 2 -fields $fields
    $fields = @(
		@{
			asset_layout_field_id = $(Get-HuduAssetLayoutFieldID -name 'Plan Name' -asset_layout_id 2)
			value = "Backup Plan1"
		},
		@{
			asset_layout_field_id = $(Get-HuduAssetLayoutFieldID -name 'Computer Name' -asset_layout_id 2)
			value = "Computer-01"
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
