# Offline tests: all HTTP requests are mocked; no Hudu credentials are required.
BeforeAll {
    $ManifestPath = Join-Path (Split-Path -Parent $PSScriptRoot) 'HuduAPI.psd1'
    Import-Module $ManifestPath -Force
}

AfterAll {
    Remove-Module HuduAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Password sharing command exports' {
    It 'exports <Name> through the module manifest' -ForEach @(
        @{ Name = 'Get-HuduPasswordShares' }
        @{ Name = 'New-HuduPasswordShare' }
        @{ Name = 'Remove-HuduPasswordShare' }
    ) {
        Get-Command -Module HuduAPI -Name $Name | Should -Not -BeNullOrEmpty
        (Import-PowerShellDataFile -LiteralPath $ManifestPath).FunctionsToExport | Should -Contain $Name
    }
}

Describe 'Get-HuduPasswordShares' {
    BeforeEach {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
    }

    It 'returns share objects with public URLs and requests 1000 results per page by default' {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith {
            @{ shares = @(
                [pscustomobject]@{ id = 7; url = 'https://hudu.example/shared/first' }
                [pscustomobject]@{ id = 8; url = 'https://hudu.example/shared/second' }
            ) }
        }

        $Result = @(Get-HuduPasswordShares -AssetPasswordId 42)

        $Result.Count | Should -Be 2
        $Result[0].id | Should -Be 7
        $Result[0].url | Should -Be 'https://hudu.example/shared/first'
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'GET' -and $Resource -eq '/api/v1/asset_passwords/42/shares' -and
            $Params.page -eq 1 -and $Params.page_size -eq 1000
        }
    }

    It 'retrieves subsequent pages until a partial page is returned' {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith {
            param($Params)
            if ($Params.page -eq 1) {
                @{ shares = @([pscustomobject]@{ id = 7 }, [pscustomobject]@{ id = 8 }) }
            } elseif ($Params.page -eq 2) {
                @{ shares = @([pscustomobject]@{ id = 9 }) }
            } else {
                throw 'Unexpected extra page requested.'
            }
        }

        $Result = @(Get-HuduPasswordShares -AssetPasswordId 42 -PageSize 2)

        $Result.id | Should -Be @(7, 8, 9)
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 2 -Exactly -ParameterFilter {
            $Resource -eq '/api/v1/asset_passwords/42/shares' -and $Params.page_size -eq 2
        }
    }

    It 'stops on an empty page, including when the preceding page was full' {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith {
            param($Params)
            if ($Params.page -eq 1) {
                @{ shares = @([pscustomobject]@{ id = 7 }) }
            } else {
                @{ shares = @() }
            }
        }

        @(Get-HuduPasswordShares -AssetPasswordId 42 -PageSize 1).Count | Should -Be 1

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 2 -Exactly
    }

    It 'returns no objects when the password has no sharing links' {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { @{ shares = @() } }

        @(Get-HuduPasswordShares -AssetPasswordId 42).Count | Should -Be 0

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly
    }

    It 'requests only the specified page and binds API parameter aliases' {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith {
            @{ shares = @([pscustomobject]@{ id = 7 }, [pscustomobject]@{ id = 8 }) }
        }

        $Result = @(Get-HuduPasswordShares -asset_password_id 42 -Page 3 -page_size 2)

        $Result.id | Should -Be @(7, 8)
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'GET' -and $Resource -eq '/api/v1/asset_passwords/42/shares' -and
            $Params.page -eq 3 -and $Params.page_size -eq 2
        }
    }

    It 'retrieves a single share using 64-bit password and share IDs' {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith {
            @{ share = [pscustomobject]@{ id = 4294967297; url = 'https://hudu.example/shared/first' } }
        }

        $Result = Get-HuduPasswordShares -PasswordId 4294967296 -ShareId 4294967297

        $Result.id | Should -Be 4294967297
        $Result.url | Should -Be 'https://hudu.example/shared/first'
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'GET' -and $Resource -eq '/api/v1/asset_passwords/4294967296/shares/4294967297' -and
            $Params.Count -eq 0
        }
    }

    It 'returns no share when the request helper returns null' {
        Get-HuduPasswordShares -AssetPasswordId 42 -Id 7 | Should -BeNullOrEmpty
        Get-HuduPasswordShares -AssetPasswordId 42 | Should -BeNullOrEmpty
    }

    It 'rejects invalid retrieval arguments: <Case>' -ForEach @(
        @{ Case = 'zero password ID'; Arguments = @{ AssetPasswordId = 0 } }
        @{ Case = 'negative password ID'; Arguments = @{ AssetPasswordId = -1 } }
        @{ Case = 'zero share ID'; Arguments = @{ AssetPasswordId = 42; Id = 0 } }
        @{ Case = 'negative share ID'; Arguments = @{ AssetPasswordId = 42; Id = -1 } }
        @{ Case = 'zero page'; Arguments = @{ AssetPasswordId = 42; Page = 0 } }
        @{ Case = 'negative page'; Arguments = @{ AssetPasswordId = 42; Page = -1 } }
        @{ Case = 'zero page size'; Arguments = @{ AssetPasswordId = 42; PageSize = 0 } }
        @{ Case = 'page size above 1000'; Arguments = @{ AssetPasswordId = 42; PageSize = 1001 } }
        @{ Case = 'ID with pagination'; Arguments = @{ AssetPasswordId = 42; Id = 7; Page = 1 } }
        @{ Case = 'ID with page size'; Arguments = @{ AssetPasswordId = 42; Id = 7; PageSize = 25 } }
    ) {
        { Get-HuduPasswordShares @Arguments } | Should -Throw

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }
}

Describe 'New-HuduPasswordShare' {
    BeforeEach {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith {
            @{ share = [pscustomobject]@{ id = 7; url = 'https://hudu.example/shared/first' } }
        }
    }

    It 'posts the required share wrapper and expiry while leaving optional fields to Hudu' {
        $Result = New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 3600

        $Result.id | Should -Be 7
        $Result.url | Should -Be 'https://hudu.example/shared/first'
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Payload = $Body | ConvertFrom-Json
            $Method -eq 'POST' -and $Resource -eq '/api/v1/asset_passwords/42/shares' -and
            $Payload.PSObject.Properties.Name -eq 'share' -and
            @($Payload.share.PSObject.Properties).Count -eq 1 -and $Payload.share.expire_in -eq 3600
        }
    }

    It 'sends every optional field, preserving JSON booleans set to <Value>' -ForEach @(
        @{ Value = $true }
        @{ Value = $false }
    ) {
        $Arguments = @{
            asset_password_id = 4294967296
            expire_in = 1
            Notes = 'Recipient notes with "quotes" and a newline' + "`n" + 'Second line'
            one_time_expire = $Value
            include_username = $Value
            include_otp = $Value
            include_url = $Value
            include_notes = $Value
        }

        $null = New-HuduPasswordShare @Arguments

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Payload = ($Body | ConvertFrom-Json).share
            $Resource -eq '/api/v1/asset_passwords/4294967296/shares' -and
            $Payload.expire_in -eq 1 -and $Payload.notes -eq $Arguments.Notes -and
            @($Payload.PSObject.Properties).Count -eq 7 -and
            $Payload.one_time_expire -is [bool] -and $Payload.one_time_expire -eq $Value -and
            $Payload.include_username -is [bool] -and $Payload.include_username -eq $Value -and
            $Payload.include_otp -is [bool] -and $Payload.include_otp -eq $Value -and
            $Payload.include_url -is [bool] -and $Payload.include_url -eq $Value -and
            $Payload.include_notes -is [bool] -and $Payload.include_notes -eq $Value
        }
    }

    It 'returns no share when the request helper returns null' {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { $null }

        New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 3600 | Should -BeNullOrEmpty
    }

    It 'rejects invalid creation arguments: <Case>' -ForEach @(
        @{ Case = 'zero password ID'; Arguments = @{ AssetPasswordId = 0; ExpireIn = 3600 } }
        @{ Case = 'negative password ID'; Arguments = @{ AssetPasswordId = -1; ExpireIn = 3600 } }
        @{ Case = 'non-expiring link'; Arguments = @{ AssetPasswordId = 42; ExpireIn = 0 } }
        @{ Case = 'negative expiry'; Arguments = @{ AssetPasswordId = 42; ExpireIn = -1 } }
    ) {
        { New-HuduPasswordShare @Arguments } | Should -Throw

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }

    It 'requires an explicit expiry' {
        (Get-Command New-HuduPasswordShare).Parameters['ExpireIn'].Attributes.Mandatory | Should -Contain $true
    }

    It 'makes no request with WhatIf' {
        New-HuduPasswordShare -AssetPasswordId 42 -ExpireIn 3600 -WhatIf | Should -BeNullOrEmpty

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }
}

Describe 'Remove-HuduPasswordShare' {
    BeforeEach {
        Mock -CommandName Invoke-HuduRequest -ModuleName HuduAPI -MockWith { }
    }

    It 'deletes the nested share resource using 64-bit IDs and API aliases' {
        Remove-HuduPasswordShare -asset_password_id 4294967296 -share_id 4294967297 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'DELETE' -and $Resource -eq '/api/v1/asset_passwords/4294967296/shares/4294967297'
        }
    }

    It 'accepts retrieved sharing link objects through the pipeline' {
        @([pscustomobject]@{ id = 7 }, [pscustomobject]@{ id = 8 }) |
            Remove-HuduPasswordShare -PasswordId 42 -Confirm:$false

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 2 -Exactly
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'DELETE' -and $Resource -eq '/api/v1/asset_passwords/42/shares/7'
        }
        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
            $Method -eq 'DELETE' -and $Resource -eq '/api/v1/asset_passwords/42/shares/8'
        }
    }

    It 'rejects invalid deletion arguments: <Case>' -ForEach @(
        @{ Case = 'zero password ID'; Arguments = @{ AssetPasswordId = 0; Id = 7 } }
        @{ Case = 'negative password ID'; Arguments = @{ AssetPasswordId = -1; Id = 7 } }
        @{ Case = 'zero share ID'; Arguments = @{ AssetPasswordId = 42; Id = 0 } }
        @{ Case = 'negative share ID'; Arguments = @{ AssetPasswordId = 42; Id = -1 } }
    ) {
        { Remove-HuduPasswordShare @Arguments -Confirm:$false } | Should -Throw

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }

    It 'makes no request with WhatIf' {
        Remove-HuduPasswordShare -AssetPasswordId 42 -Id 7 -WhatIf

        Should -Invoke -CommandName Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
    }
}
