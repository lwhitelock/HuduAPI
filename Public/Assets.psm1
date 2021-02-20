function Get-HuduAssets {
	Param (
		[Int]$id = '',
		[Int]$assetlayoutid = '',
		[Int]$companyid = '',
		[String]$name ='',
		[String]$primaryserial
	
	)
	Add-Type -AssemblyName System.Web
	
    	$ParamCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty) 
	$ParamCollection.Add('page_size',1000)
	$ParamCollection.Add('page',0)
	
	if ($primaryserial) {
	
	$Resource = 'api/v1/asset_lookup'
	$ParamCollection.Add('primary_serial',$primaryserial)
	
	else {
	
	$Resource = '/api/v1/assets'
	
	}	
	$i = 0;
	
	$AllAssets = do {
		$ParamCollection.page=$i 
		$Assets = hudu_request -Method get -Resource ($Resource + "?" + $ParamCollection.ToString())
		$i++
		$Assets.Assets
		Write-Host "Retrieved $($Assets.Assets.count) Assets" -ForegroundColor Yellow
		
		} while ($Assets.Assets.count % 1000 -eq 0 -and $Assets.Assets.count -ne 0)
		
	if ($id) {
	$AllAssets = $AllAssets | where-object {$_.id -eq $id}
	}
		
	if ($name) {
	$AllAssets = $AllAssets | where-object {$_.name -eq $name}
	}
	
	if ($assetlayoutid) {
	$AllAssets = $AllAssets | where-object {$_.asset_layout_id -eq $assetlayoutid}
	}
	
	if ($companyid) {
	$AllAssets = $AllAssets | where-object {$_.company_id -eq $companyid}
	}
	
	
	return $AllAssets
	
}
		
function New-HuduAsset {
        param(
        [String]$name,
	[Int]$asset_layout_id,
        [Array]$fields,
        [Int]$companyid
    )

    $RequestParams = @{ 
        asset = @{fields= @() }
    }
    if ($name) {
        $RequestParams.asset.add('name',$name)
    }
    
    if ($fields -is [Array]) {
      foreach ($field in $asset_fields) {
        if (($field['id']) -and ($field['value'])) {
          $RequestParams.asset.fields.add(@{id=$field['id']; value=$field['value']})
        }
      }
    }

    #remove empty keys
    $RequestParams.GetEnumerator() | ? Value
    
    return hudu_request -resource "/api/v1/companies/$companyid/assets" -method "POST"  -body  $(ConvertTo-Json $RequestParams)
    
}

function Set-HuduAsset {
    param(
    	[int]$companyid,
	[int]$id,
	[string]name,
	[int]assetlayoutid,
	[array]$fields
	)
    
    $RequestParams = @{ 
        asset = @{fields= @() }
    }

    if ($name) {
        $RequestParams.asset.add('name',$name)
    }
    if ($assetlayoutid) {
        $RequestParams.asset.add('asset_layout_id',asset_layout_id)
    }
    
    if ($fields -is [Array]) {
      foreach ($field in $fields) {
        if (($field.id) -and ($field.value)) {
          $RequestParams.asset.fields += @{id=$field.id;value=$field.value }
        }
      }
    }

    #remove empty keys
    $RequestParams.GetEnumerator() | ? Value
    
    return hudu_request -resource "/api/v1/companies/$companyid/assets/$id" -method "PUT" -Body $(ConvertTo-Json $RequestParams -Depth 5)

}
function Remove-HuduAsset {
    param(
    	[int]$companyid,
	[int]$id
	)
    return hudu_request -resource "/api/v1/companies/$companyid/assets/$id" -method "DELETE" 
