
## Release Notes
https://github.com/lwhitelock/HuduAPI/releases

## Installation

    install-module HuduAPI

## Implemented Commands
	Get-HuduActivityLogs
	Get-HuduApiKey
	Get-HuduAppInfo
	Get-HuduArticles
	Get-HuduAssetLayoutFieldID
	Get-HuduAssetLayouts
	Get-HuduAssets
	Get-HuduBaseURL
	Get-HuduCard
	Get-HuduCompanies
	Get-HuduExpirations
	Get-HuduFolderMap
	Get-HuduFolders
	Get-HuduGroups
	Get-HuduIntegrationMatchers
	Get-HuduIPAddresses
	Get-HuduLists
	Get-HuduMagicDashes
	Get-HuduNetworks
	Get-HuduObjectByUrl
	Get-HuduPasswordFolders
	Get-HuduPasswords
	Get-HuduProcedures
	Get-HuduProcedureTasks
	Get-HuduPublicPhotos
	Get-HuduRackStorageItems
	Get-HuduRackStorages
	Get-HuduRelations
	Get-HuduUploads
	Get-HuduUsers
	Get-HuduVLANs
	Get-HuduVLANZones
	Get-HuduWebsites
	Initialize-HuduFolder
	Move-HuduAssetsToNewLayout
	Move-HuduAssetsToNewLayoutDeprecated
	New-HuduAPIKey
	New-HuduArticle
	New-HuduAsset
	New-HuduAssetLayout
	New-HuduBaseURL
	New-HuduCompany
	New-HuduCustomHeaders
	New-HuduFolder
	New-HuduIPAddress
	New-HuduList
	New-HuduNetwork
	New-HuduPassword
	New-HuduPasswordFolder
	New-HuduProcedure
	New-HuduProcedureFromTemplate
	New-HuduProcedureTask
	New-HuduPublicPhoto
	New-HuduRackStorage
	New-HuduRackStorageItem
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
	Remove-HuduIPAddress
	Remove-HuduList
	Remove-HuduMagicDash
	Remove-HuduNetwork
	Remove-HuduPassword
	Remove-HuduPasswordFolder
	Remove-HuduProcedure
	Remove-HuduProcedureTask
	Remove-HuduRackStorage
	Remove-HuduRackStorageItem
	Remove-HuduRelation
	Remove-HuduUpload
	Remove-HuduVLAN
	Remove-HuduVLANZone
	Remove-HuduWebsite
	Set-HapiErrorsDirectory
	Set-HuduArticle
	Set-HuduArticleArchive
	Set-HuduAsset
	Set-HuduAssetArchive
	Set-HuduAssetLayout
	Set-HuduAssetLayoutField
	Set-HuduCompany
	Set-HuduCompanyArchive
	Set-HuduFolder
	Set-HuduIntegrationMatcher
	Set-HuduIPAddress
	Set-HuduList
	Set-HuduMagicDash
	Set-HuduNetwork
	Set-HuduPassword
	Set-HuduPasswordArchive
	Set-HuduPasswordFolder
	Set-HuduProcedure
	Set-HuduProcedureTask
	Set-HuduRackStorage
	Set-HuduRackStorageItem
	Set-HuduVLAN
	Set-HuduVLANZone
	Set-HuduWebsite
	Start-HuduExport
	Start-HuduProcedure
	Start-HuduS3Export

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
