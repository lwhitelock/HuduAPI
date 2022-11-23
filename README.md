
## Release Notes
### Version 2.3.0
```
Added new integration matching endpoints (Thank you @johnduprey)
```
### Version 2.2.1
```
Added company types to companies (Thank you @greenlighttec)
Added resource filter to get-huduassets (Thank you @johnduprey)
```
### Version 2.2.0
```
Added Get-HuduExpirations (Thank you @AdamWillford)
```
### Version 2.1.1
```
Fix for Get-HuduFolders by ID
Fix for Initialize-HuduFolder creating folders in company
```
### Version 2.1.0
```
Added the ability to set primary_serial, primary_mail, primary_model, primary_manufacturer to New-HuduAsset and Set-HuduAsset
Set fields to be optional for New-HuduAsset and Set-HuduAsset
```
### Version 2.0.0-alpha1
Added Get-HuduProcesses
### Version 2.0.0-alpha
```
Added support for 2.1.5.8
Switched to Semver
Added Get-HuduMagicDashes
Added Get-HuduRelations
Added New-HuduRelation
Added Remove-HuduRelation
General tweaks and bug fixes
```

### Version 1.22

Fixes an incorrect ID parameter for `Get-HuduWebsite`.
Adds more new API endpoints/parameters for Hudu 2.1.5.6

### Version 1.21
Refixed A missed / in Get Assets by ID

### Version 1.20
Various fixes from pull requests (Thank you homotechsual and greenlighttec)
Added aliases to all commands
Fixed camel case
Some incorrect filter names
A missed / in Get Assets by ID

### Version 1.19
Added Boolean fix to Set-HuduAssetLayouts
Fixed bug in Remove-MagicDash

### Version 1.18
Added Support for Hudu 2.1.5.6 and implemented Folders

Added:

	Get-HuduFolders
	New-HuduFolder
	Set-HuduFolder

I have also added some additional helper features for folders

	Get-HuduFolderMap # will return the structure of all folders in your KB
	Get-HuduFolderMap -company_id $company.id # will return the structure of folders under a customer.
	
You can browse to folders with

	(Get-HuduFolderMap).Folder.SubFolder.SubSubFolder

To get a specific subfolder by path or to create it and its parent folders you can pass in an array of strings to Initialize-HuduFolder:

	$Folders = @("Folder","SubFolder","SubSubFolder")
	Initialize-HuduFolder $Folders

Fixed bug in 2.1.5.6 where booleans have been fixed in asset layouts, but legacy text versions no longer work.

### Version 1.17

Fixed rate limiting in PowerShell 5

### Version 1.16

Fixed issues with UTF8 characters. Invalid characters should be stripped and correct characters sent now.

### Version 1.15

More tweaks to work around the json order issue.

### Version 1.14

Fixes for Powershell 7

Hudu has an API bug where JSON needs to be in the correct order. The module works fine with PS5 but Asset fields weren't created in PS7, This version fixes that.

### Version 1.13

Rate Limiting and Version Check

This update adds in handling for Hudu's API rate limiting. It also adds support for the new AppInfo endpoint and will check your version when both BaseURL and API key have been set. It also fixes the Get-HuduCard command.

## Notes

This is an unofficial powershell module to allow access to the Hudu API. I am not associated with Hudu other than as a customer.

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
