
## Release Notes
https://github.com/lwhitelock/HuduAPI/releases

## Installation

    install-module HuduAPI

## Languages

Colors and Object types can be referred to using common terms in the following languages
    - English
    - German
    - French
    - Italian
    - Spanish
    - Portuguese
    - Dutch
    - Polish

## Checking if Core Feature is On/Off with Get-HuduFeatureAvailability

Get-HuduFeatureAvailability returns a boolean for every object type except articles. (for articles, it returns a PSCustomObject Like Below).
```
Get-HuduFeatureAvailability -Core_Feature articles
CompanyKB CentralKB
--------- ---------
     True     False
Get-HuduFeatureAvailability -Core_Feature wissensartikel
CompanyKB CentralKB
--------- ---------
    False      True
Get-HuduFeatureAvailability -Core_Feature articoli
CompanyKB CentralKB
--------- ---------
    False     False
Get-HuduFeatureAvailability -Core_Feature artículo
CompanyKB CentralKB
--------- ---------
     True      True
```

All other core object types return True/False

```
Get-HuduFeatureAvailability -Core_Feature photo
False
Get-HuduFeatureAvailability -Core_Feature photograph
True
Get-HuduFeatureAvailability -Core_Feature processes
False
Get-HuduFeatureAvailability -Core_Feature prozedur
True
Get-HuduFeatureAvailability -Core_Feature assets
False
Get-HuduFeatureAvailability -Core_Feature ausruestung
True
Get-HuduFeatureAvailability -Core_Feature passwords
True
Get-HuduFeatureAvailability -Core_Feature credenziali
False
```

## Implemented Commands
	Get-HuduFeatureAvailability
    Copy-HuduProcedure
    Get-HuduActivityLogs
    Get-HuduAPIKey
    Get-HuduAppInfo
    Get-HuduArticles
    Get-HuduAssetLayoutFieldID
    Get-HuduAssetLayouts
    Get-HuduAssets
    Get-HuduBaseURL
    Get-HuduCard
    Get-HuduCompanies
    Get-HuduCompanyFolders
    Get-HuduFolderCleanName
    Get-HuduExpirations
    Get-HuduFlags
    Get-HuduFlagTypes
    Get-HuduExports
    Get-HuduFolderMap
    Get-HuduFolders
    Get-HuduGroups
    Get-HuduIPAddresses
    Get-HuduIntegrationMatchers
    Get-HuduLabelTypes
    Get-HuduLabels
    Get-HuduLists
    Get-HuduNetworks
    Get-HuduMagicDashes
    Get-HuduNetworks
    Get-HuduPasswords
    Get-HuduPasswordFolders
    Get-HuduPasswordShares
    Get-HuduProcedures
    Get-HuduProcedureTasks
    Get-HuduPhotos
    Get-HuduPublicPhotos
    Get-HuduRackStorageItems
    Get-HuduRackStorages
    Get-HuduRelations
    Get-HuduSubFolders
    Get-HuduUploads
    Get-HuduVLANs
    Get-HuduVLANZones
    Get-HuduUsers
    Get-HuduUsers
    Get-HuduVLANs
    Get-HuduVLANZones
    Get-HuduWebsites
    Initialize-HuduFolder
    Invoke-HuduRequest
    Move-HuduArticleCompany
    Move-HuduAssetCompany
    New-HuduAPIKey
    New-HuduArticle
    New-HuduAsset
    New-HuduAssetLayout
    New-HuduBaseURL
    New-HuduCompany
    New-HuduCustomHeaders
    New-HuduFlag
    New-HuduFlagType
    New-HuduFolder
    New-HuduIPAddress
    New-HuduList
    New-HuduLabelType
    New-HuduLabel
    New-HuduNetwork
    New-HuduPassword
    New-HuduPasswordFolder
    New-HuduPasswordShare
    New-HuduPublicPhoto
    New-HuduPhoto
    New-HuduProcedure
    New-HuduProcedureTask
    New-HuduProcedureFromTemplate
    New-HuduRackStorageItem
    New-HuduRackStorage
    New-HuduProcedure
    New-HuduProcedureTask
    New-HuduProcedureFromTemplate
    New-HuduRelation
    New-HuduUpload
    New-HuduVLAN
    New-HuduVLANZone
    New-HuduWebsite
    Remove-HuduAPIKey
    Remove-HuduArticle
    Remove-HuduAsset
    Remove-HuduBaseURL
    Remove-HuduCompany
    Remove-HuduCustomHeaders
    Remove-HuduFlag
    Remove-HuduFlagType
    Remove-HuduLabel
    Remove-HuduLabelType
    Remove-HuduIPAddress
    Remove-HuduList
    Remove-HuduMagicDash
    Remove-HuduNetwork
    Remove-HuduPassword
    Remove-HuduPasswordFolder
    Remove-HuduPasswordShare
    Remove-HuduPhoto
    Remove-HuduProcedure
    Remove-HuduProcedureTask
    Remove-HuduRackStorageItem
    Remove-HuduRackStorage
    Remove-HuduProcedure
    Remove-HuduProcedureTask
    Remove-HuduRelation
    Remove-HuduUpload
    Remove-HuduVLAN
    Remove-HuduVLANZone
    Remove-HuduWebsite
    Save-HuduExports
    Set-HuduArticle
    Set-HuduArticleArchive
    Set-HuduArticlePinned
    Set-HuduArticleUnPinned
    Set-HuduAsset
    Set-HuduAssetArchive
    Set-HuduAssetLayout
    Set-HuduAssetLayoutField
    Set-HuduCompany
    Set-HuduCompanyArchive
    Set-HuduFlag
    Set-HuduFlagType
    Set-HuduLabel
    Set-HuduLabelType
    Set-HuduFolder
    Set-HuduIntegrationMatcher
    Set-HuduIPAddress
    Set-HuduList
    Set-HuduMagicDash
    Set-HuduNetwork
    Set-HuduProcedure
    Set-HuduProcedureTask
    Set-HuduPassword
    Set-HuduPasswordFolder
    Set-HuduPasswordArchive
    Set-HuduPublicPhoto
    Set-HuduPhoto
    Set-HuduVLAN
    Set-HuduVLANZone
    Set-HuduRackStorageItem
    Set-HuduRackStorage
    Set-HuduVLAN
    Set-HuduVLANZone
    Set-HuduWebsite
    Set-HuduWebsiteArchive
    Start-HuduProcedure
    Start-HuduExport
    Start-HuduS3Export
    Set-HapiErrorsDirectory

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

## Password sharing links

Use [New-HuduPasswordShare](Docs/New-HuduPasswordShare.md) to create a public sharing link with a required expiry in seconds. The returned object includes the full public URL.

```powershell
$Share = New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 3600 -OneTimeExpire $true -IncludeUsername $true -IncludeOTP $false
$Share.url

# Retrieve all links, a single link, or a specific page.
Get-HuduPasswordShares -AssetPasswordId 42
Get-HuduPasswordShares -AssetPasswordId 42 -Id $Share.id
Get-HuduPasswordShares -AssetPasswordId 42 -Page 2 -PageSize 25

# Revoke access immediately (prompts for confirmation).
Remove-HuduPasswordShare -AssetPasswordId 42 -Id $Share.id
```

[Get-HuduPasswordShares](Docs/Get-HuduPasswordShares.md) retrieves every page by default. [Remove-HuduPasswordShare](Docs/Remove-HuduPasswordShare.md) also accepts sharing link objects through the pipeline when `-AssetPasswordId` is supplied. Creation and removal support `-WhatIf` and `-Confirm`.

These endpoints require an API key with password access. Creation requires external sharing to be enabled for the account; deletion requires destructive actions to be enabled for the API key. Optional creation fields are omitted unless supplied, and boolean fields accept both `$true` and `$false`.

## Community & Socials

[![Hudu Community](https://img.shields.io/badge/Community-Forum-blue?logo=discourse)](https://community.hudu.com/)
[![Reddit](https://img.shields.io/badge/Reddit-r%2Fhudu-FF4500?logo=reddit)](https://www.reddit.com/r/hudu)
[![YouTube](https://img.shields.io/badge/YouTube-Hudu-red?logo=youtube)](https://www.youtube.com/@hudu1715)
[![X (Twitter)](https://img.shields.io/badge/X-@HuduHQ-black?logo=x)](https://x.com/HuduHQ)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Hudu_Technologies-0A66C2?logo=linkedin)](https://www.linkedin.com/company/hudu-technologies/)
[![Facebook](https://img.shields.io/badge/Facebook-HuduHQ-1877F2?logo=facebook)](https://www.facebook.com/HuduHQ/)
[![Instagram](https://img.shields.io/badge/Instagram-@huduhq-E4405F?logo=instagram)](https://www.instagram.com/huduhq/)
[![Feature Requests](https://img.shields.io/badge/Feedback-Feature_Requests-brightgreen?logo=github)](https://hudu.canny.io/)

    
    Set-HuduArticle -name "Test" -content "<p>Html content of article</p>" -folder_id 100 -company_id 20 -article_id 10
