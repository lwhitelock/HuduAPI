@{
  Severity = @('Error', 'Warning')
  Rules = @{
    PSUseCompatibleSyntax = @{
      Enable = $true
      TargetVersions = @('5.1','6.2','7.0')
      TargetProfiles = @(
        'win-8_x64_10.0.14393.0_6.1.3_x64_4.0.30319.42000_core'
        'win-8_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework'
        'win-8_x64_6.2.9200.0_3.0_x64_4.0.30319.42000_framework'
      )
    }
    PSUseCompatibleCmdlets = @{
      Enable = $true
      compatibility = @(
        'desktop-5.1.14393.206-windows'
        'core-6.1.0-windows'
        'core-6.1.0-linux'
        'core-6.1.0-macos'
      )
    }
    PSUseCompatibleCommands = @{
      Enable = $true
      TargetProfiles = @(
        'win-8_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework'
        'win-8_x64_10.0.17763.0_6.2.4_x64_4.0.30319.42000_core'
        'win-8_x64_10.0.17763.0_7.0.0_x64_3.1.2_core'
      )
    }
  }
}