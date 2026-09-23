# Tests/Move-HuduCompany.Tests.ps1
#
# Offline tests for Move-HuduArticleCompany and Move-HuduAssetCompany.
# Invoke-HuduRequest is mocked, so these never contact a Hudu instance and need
# no credentials, unlike the integration suites in this folder.

BeforeAll {
    $ModuleRoot   = Split-Path -Parent $PSScriptRoot
    $ManifestPath = Join-Path $ModuleRoot 'HuduAPI.psd1'
    Import-Module $ManifestPath -Force
}

AfterAll {
    Remove-Module HuduAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Move-Hudu*Company command surface' {

    It 'exports <Name>' -ForEach @(
        @{ Name = 'Move-HuduArticleCompany' }
        @{ Name = 'Move-HuduAssetCompany' }
    ) {
        Get-Command -Module HuduAPI -Name $Name -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
    }

    It 'lists <Name> in the manifest FunctionsToExport' -ForEach @(
        @{ Name = 'Move-HuduArticleCompany' }
        @{ Name = 'Move-HuduAssetCompany' }
    ) {
        (Import-PowerShellDataFile -LiteralPath $ManifestPath).FunctionsToExport | Should -Contain $Name
    }

    # Regression: Move-HuduAssetCompany carried an 'assetid' alias on its own
    # -AssetId parameter, so every call failed to bind at runtime even though
    # the module imported cleanly.
    It 'declares no alias on <Name> that collides with a parameter name' -ForEach @(
        @{ Name = 'Move-HuduArticleCompany' }
        @{ Name = 'Move-HuduAssetCompany' }
    ) {
        $Command = Get-Command -Module HuduAPI -Name $Name
        $Aliases = $Command.Parameters.Values | ForEach-Object { $_.Aliases }
        @($Aliases | Where-Object { $_ -in $Command.Parameters.Keys }) | Should -BeNullOrEmpty
    }

    It 'declares Move-HuduArticleCompany -CompanyId as a nullable int' {
        $Parameter = (Get-Command -Module HuduAPI -Name Move-HuduArticleCompany).Parameters['CompanyId']
        $Parameter.ParameterType.Name | Should -Be 'Nullable`1'
        $Parameter.ParameterType.GenericTypeArguments[0].FullName | Should -Be 'System.Int32'
    }
}

Describe 'Move-HuduArticleCompany' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduArticles -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{
                article = [pscustomobject]@{
                    id         = 42
                    company_id = 7
                    folder_id  = $null
                }
            }
        }
    }

    It 'PUTs the destination company and clears a source-company folder by default' {
        Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'put' -and
            $Resource -eq '/api/v1/articles/42' -and
            ($Body | ConvertFrom-Json).article.company_id -eq 7 -and
            $null -eq ($Body | ConvertFrom-Json).article.folder_id
        }
    }

    It 'binds the snake_case aliases' {
        Move-HuduArticleCompany -article_id 42 -company_id 7 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Resource -eq '/api/v1/articles/42'
        }
    }

    It 'rejects an article id below 1 and a company id of 0' {
        { Move-HuduArticleCompany -ArticleId 0 -CompanyId 7 -WhatIf } | Should -Throw
        { Move-HuduArticleCompany -ArticleId 42 -CompanyId 0 -WhatIf } | Should -Throw
    }

    It 'makes no request under -WhatIf' {
        Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -WhatIf

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
        Should -Invoke -CommandName Get-HuduArticles -ModuleName HuduAPI -Times 0 -Exactly
    }
}

Describe 'Move-HuduArticleCompany to the central Knowledge Base' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduArticles -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{
                article = [pscustomobject]@{
                    id         = 42
                    company_id = $null
                    folder_id  = $null
                }
            }
        }
    }

    It 'PUTs company_id as null when moving to central' {
        Move-HuduArticleCompany -ArticleId 42 -CompanyId $null -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'put' -and
            $Resource -eq '/api/v1/articles/42' -and
            $null -eq ($Body | ConvertFrom-Json).article.company_id -and
            $null -eq ($Body | ConvertFrom-Json).article.folder_id
        }
    }

    It 'accepts an explicit null CompanyId without parameter binding errors' {
        { Move-HuduArticleCompany -ArticleId 42 -CompanyId $null -WhatIf } | Should -Not -Throw
    }
}

Describe 'Move-HuduArticleCompany from the central Knowledge Base to a company' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduArticles -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{
                article = [pscustomobject]@{
                    id         = 42
                    company_id = 7
                    folder_id  = $null
                }
            }
        }
    }

    It 'PUTs a destination company id when leaving central' {
        Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            ($Body | ConvertFrom-Json).article.company_id -eq 7
        }
    }
}

Describe 'Move-HuduArticleCompany with a destination folder' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduFolders -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{ id = 9; company_id = 7 }
        }
        Mock -CommandName Get-HuduArticles -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{
                article = [pscustomobject]@{
                    id         = 42
                    company_id = 7
                    folder_id  = 9
                }
            }
        }
    }

    It 'validates the folder and sends it with the company change' {
        Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -FolderId 9 -Confirm:$false

        Should -Invoke -CommandName Get-HuduFolders -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Id -eq 9
        }
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Resource -eq '/api/v1/articles/42' -and
            ($Body | ConvertFrom-Json).article.company_id -eq 7 -and
            ($Body | ConvertFrom-Json).article.folder_id -eq 9
        }
    }

    It 'binds the folder_id alias' {
        { Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -folder_id 9 -WhatIf } |
            Should -Not -Throw
    }

    It 'accepts an explicit null FolderId as a folder clear' {
        Mock -CommandName Get-HuduArticles -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{
                article = [pscustomobject]@{
                    id         = 42
                    company_id = 7
                    folder_id  = $null
                }
            }
        }

        Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -FolderId $null -Confirm:$false

        Should -Invoke -CommandName Get-HuduFolders -ModuleName HuduAPI -Times 0 -Exactly
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $null -eq ($Body | ConvertFrom-Json).article.folder_id
        }
    }
}

Describe 'Move-HuduArticleCompany with a central Knowledge Base folder' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduFolders -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{ id = 11; company_id = $null }
        }
        Mock -CommandName Get-HuduArticles -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{
                article = [pscustomobject]@{
                    id         = 42
                    company_id = $null
                    folder_id  = 11
                }
            }
        }
    }

    It 'accepts a central folder when CompanyId is null' {
        Move-HuduArticleCompany -ArticleId 42 -CompanyId $null -FolderId 11 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $null -eq ($Body | ConvertFrom-Json).article.company_id -and
            ($Body | ConvertFrom-Json).article.folder_id -eq 11
        }
    }
}

Describe 'Move-HuduArticleCompany with an invalid destination folder' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduFolders -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{ id = 9; company_id = 1 }
        }
    }

    It 'rejects a folder owned by another company before sending a PUT' {
        { Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -FolderId 9 -Confirm:$false } |
            Should -Throw '*does not belong to company 7*'

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }

    It 'rejects a company folder when moving to the central Knowledge Base' {
        { Move-HuduArticleCompany -ArticleId 42 -CompanyId $null -FolderId 9 -Confirm:$false } |
            Should -Throw '*does not belong to the central Knowledge Base*'

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }
}

Describe 'Move-HuduArticleCompany when Hudu rejects the update' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { $null }
        Mock -CommandName Get-HuduArticles -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{
                article = [pscustomobject]@{
                    id         = 42
                    company_id = 1
                    folder_id  = 3
                }
            }
        }
    }

    It 'throws when the persisted article did not move' {
        { Move-HuduArticleCompany -ArticleId 42 -CompanyId 7 -Confirm:$false } |
            Should -Throw '*did not move to company 7*'
    }

    It 'throws when a central move did not clear company_id' {
        { Move-HuduArticleCompany -ArticleId 42 -CompanyId $null -Confirm:$false } |
            Should -Throw '*did not move to the central Knowledge Base*'
    }
}

Describe 'Move-HuduAssetCompany' {

    BeforeEach {
        $script:AssetLookupCount = 0
    }

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduAssets -ModuleName HuduAPI -MockWith {
            $script:AssetLookupCount++
            if ($script:AssetLookupCount -eq 1) {
                [pscustomobject]@{ id = 42; name = 'Test Asset'; company_id = 7 }
            } else {
                [pscustomobject]@{ id = 42; name = 'Test Asset'; company_id = 9 }
            }
        }
    }

    # The company in the URL identifies the asset, so it has to be the company
    # that currently owns it (7), not the destination (9).
    It 'PUTs to the current company path with the destination company in the body' {
        Move-HuduAssetCompany -AssetId 42 -CompanyId 9 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'put' -and
            $Resource -eq '/api/v1/companies/7/assets/42' -and
            ($Body | ConvertFrom-Json).asset.company_id -eq 9
        }
    }

    It 'binds -AssetId without an alias conflict' {
        { Move-HuduAssetCompany -AssetId 42 -CompanyId 9 -WhatIf } | Should -Not -Throw
    }

    It 'binds the snake_case aliases' {
        Move-HuduAssetCompany -asset_id 42 -company_id 9 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Resource -eq '/api/v1/companies/7/assets/42'
        }
    }

    It 'rejects an id below 1' {
        { Move-HuduAssetCompany -AssetId 0 -CompanyId 9 -WhatIf } | Should -Throw
        { Move-HuduAssetCompany -AssetId 42 -CompanyId 0 -WhatIf } | Should -Throw
    }

    It 'makes no request under -WhatIf' {
        Move-HuduAssetCompany -AssetId 42 -CompanyId 9 -WhatIf

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }
}

Describe 'Move-HuduAssetCompany when the lookup returns a collection' {

    BeforeEach {
        $script:AssetLookupCount = 0
    }

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduAssets -ModuleName HuduAPI -MockWith {
            $script:AssetLookupCount++
            if ($script:AssetLookupCount -eq 1) {
                @(
                    [pscustomobject]@{ id = 42; name = 'Test Asset'; company_id = 7 }
                    [pscustomobject]@{ id = 43; name = 'Other Asset'; company_id = 8 }
                )
            } else {
                [pscustomobject]@{ id = 42; name = 'Test Asset'; company_id = 9 }
            }
        }
    }

    It 'uses a single company id in the URL instead of an array' {
        Move-HuduAssetCompany -AssetId 42 -CompanyId 9 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Resource -eq '/api/v1/companies/7/assets/42'
        }
    }
}

Describe 'Move-HuduAssetCompany when the asset does not exist' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
        Mock -CommandName Get-HuduAssets -ModuleName HuduAPI -MockWith { $null }
    }

    It 'throws rather than building a request against a missing company id' {
        { Move-HuduAssetCompany -AssetId 42 -CompanyId 9 -Confirm:$false } |
            Should -Throw '*could not be found*'

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }
}

Describe 'Move-HuduAssetCompany when Hudu rejects the update' {

    BeforeAll {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { $null }
        Mock -CommandName Get-HuduAssets -ModuleName HuduAPI -MockWith {
            [pscustomobject]@{ id = 42; name = 'Test Asset'; company_id = 7 }
        }
    }

    It 'throws when the persisted asset did not move' {
        { Move-HuduAssetCompany -AssetId 42 -CompanyId 9 -Confirm:$false } |
            Should -Throw '*did not move to company 9*'
    }
}
