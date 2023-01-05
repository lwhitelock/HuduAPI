function Get-HuduObjectByUrl {
	[CmdletBinding()]
	Param (
		[uri]$Url
	)
	
	if ((Get-HuduBaseURL) -match $Url.Authority) {
		$null,$Type,$Slug = $Url.PathAndQuery -split '/'
		
		$SlugSplat = @{
			Slug = $Slug
		}

		switch ($Type) {
			'a' { # Asset
				Get-HuduAssets @SlugSplat
			}
			'admin' { # Admin path
				$null, $null, $Type, $Slug = $Url.PathAndQuery -split '/'
				$SlugSplat = @{
					Slug = $Slug
				}
				switch ($Type) {
					'asset_layouts' { # Asset layouts
						Get-HuduAssetLayouts @SlugSplat
					}
				}
			}
			'c' { # Company
				Get-HuduCompanies @SlugSplat
			}
			'kba' { # KB article
				Get-HuduArticles @SlugSplat
			}
			'passwords' { # Passwords
				Get-HuduPasswords @SlugSplat
			}
			'websites' { # Website
				Get-HuduWebsites @SlugSplat
			}
			default {
				Write-Error "Unsupported object type $Type"
			}
		}
	}
	else {
		Write-Error 'Provided URL does not match Hudu Base URL'
	}
}
 