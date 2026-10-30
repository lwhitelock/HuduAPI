$ModulePath = Join-Path $PSScriptRoot '../HuduAPI.psd1'
Import-Module $ModulePath -Force -ErrorAction Stop

Describe 'Asset layout number field defaults' {
    InModuleScope HuduAPI {
        BeforeEach {
            Mock Get-Culture { [System.Globalization.CultureInfo]::GetCultureInfo('en-GB') }
            Mock Invoke-HuduRequest {
                param($Body)
                $Body | ConvertFrom-Json
            }
            Mock Get-HuduAssetLayouts {
                [PSCustomObject]@{
                    id = 42
                    name = 'Test layout'
                    icon = 'fas fa-home'
                    color = '#ffffff'
                    icon_color = '#000000'
                    include_passwords = $false
                    include_photos = $false
                    include_comments = $false
                    include_files = $false
                    fields = @(
                        [PSCustomObject]@{ id = 1; label = 'Cost'; field_type = 'Number'; number_type = 'currency'; currency_code = 'CAD' }
                        [PSCustomObject]@{ id = 2; label = 'Count'; field_type = 'Number'; number_type = 'number' }
                    )
                }
            }
        }

        Context '<Command>' -ForEach @(
            @{ Command = 'New-HuduAssetLayout' }
            @{ Command = 'Set-HuduAssetLayout' }
        ) {
            BeforeEach {
                $CommandParameters = @{ Confirm = $false }
                if ($Command -eq 'New-HuduAssetLayout') {
                    $CommandParameters.Name = 'Test layout'
                    $CommandParameters.Icon = 'fas fa-home'
                    $CommandParameters.Color = '#ffffff'
                    $CommandParameters.IconColor = '#000000'
                } else {
                    $CommandParameters.Id = 42
                }
            }

            It 'normalizes the outgoing number field: <Scenario>' -TestCases @(
                @{ Scenario = 'currency without a code'; Options = @{ number_type = 'currency' }; ExpectedType = 'currency'; ExpectedCurrency = 'GBP' }
                @{ Scenario = 'currency with an invalid code'; Options = @{ number_type = 'currency'; currency_code = 'invalid' }; ExpectedType = 'currency'; ExpectedCurrency = 'GBP' }
                @{ Scenario = 'currency with a blank code'; Options = @{ number_type = 'currency'; currency_code = ' ' }; ExpectedType = 'currency'; ExpectedCurrency = 'GBP' }
                @{ Scenario = 'explicit currency'; Options = @{ number_type = ' CURRENCY '; currency_code = ' cad ' }; ExpectedType = 'currency'; ExpectedCurrency = 'CAD' }
                @{ Scenario = 'code implies currency'; Options = @{ currency_code = 'eur' }; ExpectedType = 'currency'; ExpectedCurrency = 'EUR' }
                @{ Scenario = 'number overrides a stale code'; Options = @{ number_type = 'number'; currency_code = 'CAD' }; ExpectedType = 'number'; ExpectedCurrency = $null }
                @{ Scenario = 'percentage overrides a stale code'; Options = @{ number_type = 'percentage'; currency_code = 'CAD' }; ExpectedType = 'percentage'; ExpectedCurrency = $null }
                @{ Scenario = 'percent alias'; Options = @{ number_type = ' PERCENT ' }; ExpectedType = 'percentage'; ExpectedCurrency = $null }
            ) {
                param($Options, $ExpectedType, $ExpectedCurrency)
                $Field = @{ label = 'Value'; field_type = 'number' }
                foreach ($Key in $Options.Keys) {
                    $Field[$Key] = $Options[$Key]
                }
                $Result = & $Command @CommandParameters -Fields @($Field)
                $Result.asset_layout.fields[0].field_type | Should -BeExactly 'Number'
                $Result.asset_layout.fields[0].number_type | Should -BeExactly $ExpectedType
                $Result.asset_layout.fields[0].currency_code | Should -Be $ExpectedCurrency
                $Result.asset_layout.fields[0].PSObject.Properties.Name | Should -Not -Contain 'is_location'
                Should -Invoke Invoke-HuduRequest -Times 1 -Exactly
            }

            It 'leaves an ordinary Number field without currency defaults' {
                $Result = & $Command @CommandParameters -Fields @(@{ label = 'Count'; field_type = 'Number' })
                $Result.asset_layout.fields[0].PSObject.Properties.Name | Should -Not -Contain 'number_type'
                $Result.asset_layout.fields[0].PSObject.Properties.Name | Should -Not -Contain 'currency_code'
                Should -Invoke Get-Culture -Times 0 -Exactly
            }

            It 'does not apply currency defaults to another field type' {
                $Result = & $Command @CommandParameters -Fields @(@{ label = 'Name'; field_type = 'Text' })
                $Result.asset_layout.fields[0].PSObject.Properties.Name | Should -Not -Contain 'currency_code'
                Should -Invoke Get-Culture -Times 0 -Exactly
            }

            It 'rejects an unknown number type before writing' {
                { & $Command @CommandParameters -Fields @(@{ label = 'Count'; field_type = 'Number'; number_type = 'typo' }) } | Should -Throw '*Invalid number_type*'
                Should -Invoke Invoke-HuduRequest -Times 0 -Exactly
            }

            It 'does not write with WhatIf' {
                & $Command @CommandParameters -Fields @(@{ label = 'Cost'; field_type = 'Number'; number_type = 'currency' }) -WhatIf
                Should -Invoke Invoke-HuduRequest -Times 0 -Exactly
            }
        }

        It 'preserves existing fields when updating only layout metadata' {
            $Result = Set-HuduAssetLayout -Id 42 -Name 'Renamed' -Confirm:$false
            $Result.asset_layout.fields[0].currency_code | Should -Be 'CAD'
            Should -Invoke Get-Culture -Times 0 -Exactly
        }

        It 'switches an ordinary number field to currency when its code is set' {
            $null = Set-HuduAssetLayoutField -LayoutId 42 -FieldLabel 'Count' -PropertyName 'CURRENCY_CODE' -PropertyValue ' eur '
            Should -Invoke Invoke-HuduRequest -Times 1 -Exactly -ParameterFilter {
                $Payload = $Body | ConvertFrom-Json
                $Payload.asset_layout.fields[1].number_type -eq 'currency' -and
                $Payload.asset_layout.fields[1].currency_code -eq 'EUR' -and
                $Payload.asset_layout.fields[0].currency_code -eq 'CAD'
            }
        }

        It 'defaults a blank currency code from the single field setter: <Code>' -TestCases @(
            @{ Code = '' }
            @{ Code = $null }
            @{ Code = 'invalid' }
        ) {
            param($Code)
            $null = Set-HuduAssetLayoutField -LayoutId 42 -FieldLabel 'Cost' -PropertyName 'currency_code' -PropertyValue $Code
            Should -Invoke Invoke-HuduRequest -Times 1 -Exactly -ParameterFilter {
                ($Body | ConvertFrom-Json).asset_layout.fields[0].currency_code -eq 'GBP'
            }
        }

        It 'switches a currency field to percentage without the stale code reverting it' {
            $null = Set-HuduAssetLayoutField -LayoutId 42 -FieldLabel 'Cost' -PropertyName 'number_type' -PropertyValue 'percent'
            Should -Invoke Invoke-HuduRequest -Times 1 -Exactly -ParameterFilter {
                $Field = ($Body | ConvertFrom-Json).asset_layout.fields[0]
                $Field.number_type -eq 'percentage' -and $Field.PSObject.Properties.Name -notcontains 'currency_code'
            }
        }

        It 'preserves an existing currency when editing another property' {
            $null = Set-HuduAssetLayoutField -LayoutId 42 -FieldLabel 'Cost' -PropertyName 'label' -PropertyValue 'Price'
            Should -Invoke Invoke-HuduRequest -Times 1 -Exactly -ParameterFilter {
                $Field = ($Body | ConvertFrom-Json).asset_layout.fields[0]
                $Field.label -eq 'Price' -and $Field.currency_code -eq 'CAD'
            }
            Should -Invoke Get-Culture -Times 0 -Exactly
        }

        It 'rejects a currency code on a non-number field before writing' {
            Mock Get-HuduAssetLayouts {
                [PSCustomObject]@{ id = 42; fields = @([PSCustomObject]@{ label = 'Name'; field_type = 'Text' }) }
            }
            { Set-HuduAssetLayoutField -LayoutId 42 -FieldLabel 'Name' -PropertyName 'currency_code' -PropertyValue 'USD' } | Should -Throw '*only be set on Number fields*'
            Should -Invoke Invoke-HuduRequest -Times 0 -Exactly
        }
    }
}

Describe 'Assert-CurrencyISO4217' {
    InModuleScope HuduAPI {
        BeforeEach {
            Mock Get-Culture { [System.Globalization.CultureInfo]::GetCultureInfo('en-GB') }
        }

        It 'preserves explicit current and legacy codes: <Code>' -TestCases @(
            @{ Code = ' cad '; Expected = 'CAD' }
            @{ Code = 'SLE'; Expected = 'SLE' }
            @{ Code = 'XCG'; Expected = 'XCG' }
            @{ Code = 'ZWG'; Expected = 'ZWG' }
            @{ Code = 'HRK'; Expected = 'HRK' }
        ) {
            param($Code, $Expected)
            Assert-CurrencyISO4217 -CurrencyCode $Code | Should -BeExactly $Expected
            Should -Invoke Get-Culture -Times 0 -Exactly
        }

        It 'defaults missing input to the executing session culture' {
            Assert-CurrencyISO4217 | Should -Be 'GBP'
        }

        It 'uses USD for invariant culture' {
            Mock Get-Culture { [System.Globalization.CultureInfo]::InvariantCulture }
            Assert-CurrencyISO4217 | Should -Be 'USD'
        }

        It 'uses USD for a neutral culture without a region' {
            Mock Get-Culture { [System.Globalization.CultureInfo]::GetCultureInfo('en') }
            Assert-CurrencyISO4217 | Should -Be 'USD'
        }

        It 'uses USD when culture lookup fails' {
            Mock Get-Culture { Write-Error 'Culture lookup failed' }
            Assert-CurrencyISO4217 -CurrencyCode 'invalid' | Should -Be 'USD'
        }

        It 'uses USD for a region without a currency' {
            Mock Get-Culture { [System.Globalization.CultureInfo]::GetCultureInfo('en-AQ') }
            Assert-CurrencyISO4217 | Should -Be 'USD'
        }
    }
}
