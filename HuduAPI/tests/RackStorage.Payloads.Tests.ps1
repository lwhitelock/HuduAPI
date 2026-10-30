# Offline request-contract tests. No Hudu instance or credentials are required.
BeforeAll {
    Import-Module (Join-Path $PSScriptRoot '../HuduAPI.psd1') -Force -ErrorAction Stop
}

AfterAll {
    Remove-Module HuduAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Rack storage request payloads and defaults' {
    BeforeEach {
        Mock Invoke-HuduRequest -ModuleName HuduAPI {
            param($Method, $Resource, $Params, $Body)
            [pscustomobject]@{
                Method = $Method
                Resource = $Resource
                Params = $Params
                Payload = if ($Body) { $Body | ConvertFrom-Json -AsHashtable } else { $null }
            }
        }
    }

    Context 'New-HuduRackStorageItem' {
        It 'creates an asset-backed item with front, used, and single-unit defaults' {
            $Request = New-HuduRackStorageItem -RackStorageId 10 -RackStorageRoleId 45 -AssetId 123 -StartUnit 5

            $Request.Method | Should -Be 'POST'
            $Request.Resource | Should -Be '/api/v1/rack_storage_items'
            $Request.Payload.Count | Should -Be 1
            $Item = $Request.Payload.rack_storage_item
            $Item.rack_storage_id | Should -Be 10
            $Item.rack_storage_role_id | Should -Be 45
            $Item.asset_id | Should -Be 123
            $Item.start_unit | Should -Be 5
            $Item.end_unit | Should -Be 5
            $Item.status | Should -Be 1
            $Item.side | Should -Be 0
            $Item.ContainsKey('company_id') | Should -BeFalse
            $Item.ContainsKey('max_wattage') | Should -BeFalse
            $Item.ContainsKey('power_draw') | Should -BeFalse
            $Item.ContainsKey('reserved_message') | Should -BeFalse
        }

        It 'creates a reservation without an asset or company and supports unit zero' {
            $Request = New-HuduRackStorageItem -RackStorageId 10 -RackStorageRoleId 45 -StartUnit 0 -ReservedMessage 'Future server'

            $Item = $Request.Payload.rack_storage_item
            $Item.start_unit | Should -Be 0
            $Item.end_unit | Should -Be 0
            $Item.status | Should -Be 0
            $Item.reserved_message | Should -Be 'Future server'
            $Item.ContainsKey('asset_id') | Should -BeFalse
            $Item.ContainsKey('company_id') | Should -BeFalse
        }

        It 'preserves explicit status <Status>, power zero, empty text, and legacy positional arguments' -ForEach @(
            @{ Status = 0 }
            @{ Status = 1 }
        ) {
            $Request = New-HuduRackStorageItem 10 45 123 0 4 $Status 1 0 0 '' 34

            $Item = $Request.Payload.rack_storage_item
            $Item.company_id | Should -Be 34
            $Item.start_unit | Should -Be 0
            $Item.end_unit | Should -Be 4
            $Item.status | Should -Be $Status
            $Item.status | Should -BeOfType ([long])
            $Item.side | Should -Be 1
            $Item.ContainsKey('max_wattage') | Should -BeTrue
            $Item.max_wattage | Should -Be 0
            $Item.ContainsKey('power_draw') | Should -BeTrue
            $Item.power_draw | Should -Be 0
            $Item.ContainsKey('reserved_message') | Should -BeTrue
            $Item.reserved_message | Should -BeExactly ''
        }

        It 'honors an explicit status when no asset is provided' {
            $Request = New-HuduRackStorageItem -RackStorageId 10 -RackStorageRoleId 45 -StartUnit 5 -Status 1
            $Request.Payload.rack_storage_item.status | Should -Be 1
        }

    }

    Context 'Set-HuduRackStorageItem' {
        It 'sends all supplied fields in the documented wrapper without a preliminary GET' {
            $Request = Set-HuduRackStorageItem -Id 456 -RackStorageRoleId 45 -AssetId 123 -StartUnit 10 -EndUnit 15 -Status 0 -Side Rear -MaxWattage 500 -PowerDraw 250 -ReservedMessage 'Maintenance'

            $Request.Method | Should -Be 'PUT'
            $Request.Resource | Should -Be '/api/v1/rack_storage_items/456'
            $Request.Payload.Count | Should -Be 1
            $Item = $Request.Payload.rack_storage_item
            $Item.Count | Should -Be 9
            $Item.rack_storage_role_id | Should -Be 45
            $Item.asset_id | Should -Be 123
            $Item.start_unit | Should -Be 10
            $Item.end_unit | Should -Be 15
            $Item.status | Should -Be 0
            $Item.side | Should -Be 1
            $Item.max_wattage | Should -Be 500
            $Item.power_draw | Should -Be 250
            $Item.reserved_message | Should -Be 'Maintenance'
            Should -Invoke Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly
            Should -Invoke Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly -ParameterFilter { $Method -eq 'GET' }
        }

        It 'leaves omitted units, side, and status unchanged on a partial update' {
            $Request = Set-HuduRackStorageItem -Id 456 -PowerDraw 120
            $Item = $Request.Payload.rack_storage_item
            $Item.Count | Should -Be 1
            $Item.power_draw | Should -Be 120
            Should -Invoke Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly
        }

        It 'sends zero values and clears a reserved message' {
            $Request = Set-HuduRackStorageItem -Id 456 -StartUnit 0 -EndUnit 0 -Status 0 -Side 0 -MaxWattage 0 -PowerDraw 0 -ReservedMessage ''
            $Item = $Request.Payload.rack_storage_item
            $Item.Count | Should -Be 7
            foreach ($Field in @('start_unit', 'end_unit', 'status', 'side', 'max_wattage', 'power_draw')) {
                $Item.ContainsKey($Field) | Should -BeTrue
                $Item[$Field] | Should -Be 0
                $Item[$Field] | Should -BeOfType ([long])
            }
            $Item.ContainsKey('reserved_message') | Should -BeTrue
            $Item.reserved_message | Should -BeExactly ''
        }

        It 'does not infer an end unit or status when only the start unit changes' {
            $Request = Set-HuduRackStorageItem -Id 456 -StartUnit 10
            $Request.Payload.rack_storage_item.Count | Should -Be 1
            $Request.Payload.rack_storage_item.start_unit | Should -Be 10
        }

    }

    Context 'Side input compatibility' {
        It 'accepts <Side> and sends names for GET but integers for POST and PUT' -ForEach @(
            @{ Side = 0; Number = 0; Name = 'Front' }
            @{ Side = 1; Number = 1; Name = 'Rear' }
            @{ Side = '0'; Number = 0; Name = 'Front' }
            @{ Side = '1'; Number = 1; Name = 'Rear' }
            @{ Side = 'front'; Number = 0; Name = 'Front' }
            @{ Side = 'REAR'; Number = 1; Name = 'Rear' }
        ) {
            $Get = Get-HuduRackStorageItems -Side $Side
            $New = New-HuduRackStorageItem -RackStorageId 10 -RackStorageRoleId 45 -StartUnit 5 -Side $Side
            $Set = Set-HuduRackStorageItem -Id 456 -Side $Side

            $Get.Params.side | Should -BeExactly $Name
            foreach ($Request in @($New, $Set)) {
                $Request.Payload.rack_storage_item.side | Should -Be $Number
                $Request.Payload.rack_storage_item.side | Should -BeOfType ([long])
            }
        }

        It 'rejects an unknown side before making a request' {
            { Get-HuduRackStorageItems -Side 'typo' } | Should -Throw
            { New-HuduRackStorageItem -RackStorageId 10 -RackStorageRoleId 45 -StartUnit 5 -Side 'typo' } | Should -Throw
            { Set-HuduRackStorageItem -Id 456 -Side 'typo' } | Should -Throw
            Should -Invoke Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
        }
    }

    Context 'Rack storage writes' {
        It 'creates a rack with unit 1 and leaves unspecified optional fields to Hudu' {
            $Request = New-HuduRackStorage -Name 'Rack A' -CompanyId 34 -Height 42 -Width 19
            $Request.Method | Should -Be 'POST'
            $Request.Resource | Should -Be '/api/v1/rack_storages'
            $Request.Payload.Count | Should -Be 5
            $Request.Payload.name | Should -Be 'Rack A'
            $Request.Payload.company_id | Should -Be 34
            $Request.Payload.height | Should -Be 42
            $Request.Payload.width | Should -Be 19
            $Request.Payload.starting_unit | Should -Be 1
            $Request.Payload.ContainsKey('location_id') | Should -BeFalse
            $Request.Payload.ContainsKey('description') | Should -BeFalse
            $Request.Payload.ContainsKey('max_wattage') | Should -BeFalse
        }

        It 'preserves explicit optional fields and zero-based numbering on creation' {
            $Request = New-HuduRackStorage -Name 'Rack A' -CompanyId 34 -Height 42 -Width 19 -LocationId 12 -Description '' -MaxWattage 0 -StartingUnit 0
            $Request.Payload.Count | Should -Be 8
            $Request.Payload.location_id | Should -Be 12
            $Request.Payload.description | Should -BeExactly ''
            $Request.Payload.max_wattage | Should -Be 0
            $Request.Payload.starting_unit | Should -Be 0
        }

        It 'updates all rack fields with a flat payload and preserves zero and empty values' {
            $Request = Set-HuduRackStorage -Id 123 -Name 'Rack B' -CompanyId 34 -Height 42 -Width 19 -LocationId 12 -Description '' -MaxWattage 0 -StartingUnit 0
            $Request.Method | Should -Be 'PUT'
            $Request.Resource | Should -Be '/api/v1/rack_storages/123'
            $Request.Payload.Count | Should -Be 8
            $Request.Payload.name | Should -Be 'Rack B'
            $Request.Payload.company_id | Should -Be 34
            $Request.Payload.location_id | Should -Be 12
            $Request.Payload.height | Should -Be 42
            $Request.Payload.width | Should -Be 19
            $Request.Payload.description | Should -BeExactly ''
            $Request.Payload.max_wattage | Should -Be 0
            $Request.Payload.starting_unit | Should -Be 0
        }

        It 'does not apply creation defaults during a rack update' {
            $Request = Set-HuduRackStorage -Id 123 -Name 'Rack B'
            $Request.Payload.Count | Should -Be 1
            $Request.Payload.name | Should -Be 'Rack B'
        }
    }

    Context 'Update argument handling' {
        It 'rejects an update with no properties: <Command>' -ForEach @(
            @{ Command = 'Set-HuduRackStorage' }
            @{ Command = 'Set-HuduRackStorageItem' }
        ) {
            { & $Command -Id 123 -Verbose } | Should -Throw '*at least one*'
            Should -Invoke Invoke-HuduRequest -ModuleName HuduAPI -Times 0 -Exactly
        }
    }

    Context 'Collection filters' {
        It 'uses the documented item filter keys and preserves unit and status zero' {
            $Request = Get-HuduRackStorageItems -RoleId 45 -AssetId 123 -StartUnit 0 -EndUnit 0 -Status 0 -Side 0
            $Request.Resource | Should -Be '/api/v1/rack_storage_items'
            $Request.Params.Count | Should -Be 6
            $Request.Params.rack_storage_role_id | Should -Be 45
            $Request.Params.asset_id | Should -Be 123
            $Request.Params.start_unit | Should -Be 0
            $Request.Params.end_unit | Should -Be 0
            $Request.Params.status | Should -Be 0
            $Request.Params.side | Should -BeExactly 'Front'
            $Request.Params.ContainsKey('starting_unit') | Should -BeFalse
        }

        It 'sends the documented rack storage filters without unrelated defaults' {
            $Request = Get-HuduRackStorages -CompanyId 34 -LocationId 12 -Height 42 -MinWidth 0 -MaxWidth 19
            $Request.Resource | Should -Be '/api/v1/rack_storages'
            $Request.Params.Count | Should -Be 5
            $Request.Params.company_id | Should -Be 34
            $Request.Params.location_id | Should -Be 12
            $Request.Params.height | Should -Be 42
            $Request.Params.min_width | Should -Be 0
            $Request.Params.max_width | Should -Be 19
        }
    }

    Context '<Command> retrieval and date ranges' -ForEach @(
        @{ Command = 'Get-HuduRackStorages'; Resource = '/api/v1/rack_storages' }
        @{ Command = 'Get-HuduRackStorageItems'; Resource = '/api/v1/rack_storage_items' }
    ) {
        It 'sends an empty hashtable when listing without filters' {
            $Request = & $Command
            $Request.Method | Should -Be 'GET'
            $Request.Resource | Should -Be $Resource
            $Request.Params | Should -BeOfType ([hashtable])
            $Request.Params.Count | Should -Be 0
        }

        It 'retrieves an item by ID and passes numeric response fields through unchanged' {
            $ExpectedResource = "$Resource/123"
            Mock Invoke-HuduRequest -ModuleName HuduAPI {
                [pscustomobject]@{ id = 123; side = 0; status = 1; company_id = 34; url = 'https://hudu.example/record' }
            }
            $Result = & $Command -Id 123
            $Result.id | Should -Be 123
            $Result.side | Should -Be 0
            $Result.status | Should -Be 1
            $Result.url | Should -Be 'https://hudu.example/record'
            Should -Invoke Invoke-HuduRequest -ModuleName HuduAPI -Times 1 -Exactly -ParameterFilter {
                $Method -eq 'GET' -and $Resource -eq $ExpectedResource
            }
        }

        It 'supports a created-after range without sending an empty updated filter' {
            $Request = & $Command -CreatedAfter ([datetime]'2026-10-01T00:00:00Z')
            $Request.Params.Count | Should -Be 1
            $Request.Params.created_at | Should -Be '2026-10-01T00:00:00Z,'
        }

        It 'supports a created-before range without an implicit lower bound' {
            $Request = & $Command -CreatedBefore ([datetime]'2026-10-01T00:00:00Z')
            $Request.Params.Count | Should -Be 1
            $Request.Params.created_at | Should -Be ',2026-10-01T00:00:00Z'
        }

        It 'supports an updated-after range without an implicit upper bound' {
            $Request = & $Command -UpdatedAfter ([datetime]'2026-10-01T00:00:00Z')
            $Request.Params.Count | Should -Be 1
            $Request.Params.updated_at | Should -Be '2026-10-01T00:00:00Z,'
        }

        It 'supports an updated-before range without sending an empty created filter' {
            $Request = & $Command -UpdatedBefore ([datetime]'2026-10-01T00:00:00Z')
            $Request.Params.Count | Should -Be 1
            $Request.Params.updated_at | Should -Be ',2026-10-01T00:00:00Z'
        }

        It 'supports simultaneous created and updated ranges' {
            $Start = ([datetimeoffset]'2026-10-01T12:15:00+02:00').UtcDateTime
            $End = [datetime]'2026-10-02T00:00:00Z'
            $Request = & $Command -CreatedAfter $Start -CreatedBefore $End -UpdatedAfter $Start -UpdatedBefore $End
            $Request.Params.Count | Should -Be 2
            $Request.Params.created_at | Should -Be '2026-10-01T10:15:00Z,2026-10-02T00:00:00Z'
            $Request.Params.updated_at | Should -Be '2026-10-01T10:15:00Z,2026-10-02T00:00:00Z'
        }
    }
}
