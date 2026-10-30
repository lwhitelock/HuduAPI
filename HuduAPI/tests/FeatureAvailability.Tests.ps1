$ModulePath = Join-Path $PSScriptRoot '..' 'HuduAPI.psd1'
Remove-Module HuduAPI -Force -ErrorAction SilentlyContinue
Import-Module $ModulePath -Force

Describe 'Get-HuduFeatureAvailability' {
    InModuleScope HuduAPI {
        It 'returns false for central KB when the article create probe reports the feature is disabled' {
            Mock Invoke-HuduFeatureAvailabilityProbe {
                param($Resource, $Params, $Method, $Body)

                if ($Resource -eq '/api/v1/companies') {
                    return [PSCustomObject]@{
                        companies = @([PSCustomObject]@{ id = 42 })
                    }
                }

                if ($Resource -eq '/api/v1/articles' -and $Method -eq 'POST' -and $Body -like '*folder_id*' -and $Body -notlike '*company_id*') {
                    throw '{ "error": "Central KB is disabled for this instance" }'
                }

                throw 'Name can''t be blank'
            }

            $Result = Get-HuduFeatureAvailability -Core_Feature article

            $Result.CentralKB | Should -BeFalse
            $Result.CompanyKB | Should -BeTrue
        }

        It 'returns false for company KB when the company-scoped article create probe reports the feature is disabled' {
            Mock Invoke-HuduFeatureAvailabilityProbe {
                param($Resource, $Params, $Method, $Body)

                if ($Resource -eq '/api/v1/companies') {
                    return [PSCustomObject]@{
                        companies = @([PSCustomObject]@{ id = 42 })
                    }
                }

                if ($Resource -eq '/api/v1/articles' -and $Method -eq 'POST' -and $Body -like '*folder_id*' -and $Body -like '*company_id*') {
                    throw '{ "error": "Company KB is disabled for this instance" }'
                }

                throw 'Name can''t be blank'
            }

            $Result = Get-HuduFeatureAvailability -Core_Feature article

            $Result.CentralKB | Should -BeTrue
            $Result.CompanyKB | Should -BeFalse
        }

        It 'returns true for KB scopes when the article create probe reaches validation' {
            Mock Invoke-HuduFeatureAvailabilityProbe {
                param($Resource, $Params, $Method, $Body)

                if ($Resource -eq '/api/v1/companies') {
                    return [PSCustomObject]@{
                        companies = @([PSCustomObject]@{ id = 42 })
                    }
                }

                throw 'Name can''t be blank'
            }

            $Result = Get-HuduFeatureAvailability -Core_Feature article

            $Result.CentralKB | Should -BeTrue
            $Result.CompanyKB | Should -BeTrue
        }

        It 'deletes an article if the create probe unexpectedly succeeds' {
            $RemovedArticleId = $null

            Mock Get-HuduBaseURL {
                'https://example.hudu.test'
            }

            Mock Invoke-HuduFeatureAvailabilityRequest {
                param($Method, $Uri)
                if ($Method -eq 'DELETE') {
                    $script:RemovedArticleId = $Uri.AbsolutePath.Split('/')[-1]
                }
            }

            Mock Invoke-HuduFeatureAvailabilityProbe {
                param($Resource, $Params, $Method, $Body)

                if ($Resource -eq '/api/v1/companies') {
                    return [PSCustomObject]@{
                        companies = @([PSCustomObject]@{ id = 42 })
                    }
                }

                [PSCustomObject]@{
                    article = [PSCustomObject]@{
                        id = 123
                    }
                }
            }

            $Result = Get-HuduFeatureAvailability -Core_Feature article

            $Result.CentralKB | Should -BeTrue
            $Result.CompanyKB | Should -BeTrue
            $script:RemovedArticleId | Should -Be '123'
        }

        It 'returns false for passwords when the password endpoint reports Bad credentials' {
            Mock Invoke-HuduFeatureAvailabilityProbe {
                throw 'Bad credentials'
            } -ParameterFilter {
                $Resource -eq '/api/v1/asset_passwords'
            }

            Get-HuduFeatureAvailability -Core_Feature passwords | Should -BeFalse
        }

        It 'does not hide Bad credentials for non-password features' {
            Mock Invoke-HuduFeatureAvailabilityProbe {
                throw 'Bad credentials'
            } -ParameterFilter {
                $Resource -eq '/api/v1/companies'
            }

            { Get-HuduFeatureAvailability -Core_Feature companies } | Should -Throw -ExpectedMessage '*Bad credentials*'
        }
    }
}
