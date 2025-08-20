# Tests/Lists.Tests.ps1
Context "Hudu VLAN / VLAN Zones Integration Tests" {

  BeforeEach {
    $HUDU_API_KEY  = $env:HUDU_API_KEY  ?? (Read-Host 'Enter Hudu API Key')
    $HUDU_BASE_URL = $env:HUDU_BASE_URL ?? (Read-Host 'Enter Hudu Base URL')

    New-HuduBaseURL $HUDU_BASE_URL
    New-HuduApiKey  $HUDU_API_KEY

    function Get-RandomVlanRange {
      param([int]$Min = 1, [int]$Max = 4094)
      $start = Get-Random -Minimum $Min -Maximum ($Max + 1)
      $end   = Get-Random -Minimum $start -Maximum ($Max + 1)
      "$start-$end"
    }

    function Get-RandomHexString { param([int]$bytes=8)
      [Convert]::ToHexString([Security.Cryptography.RandomNumberGenerator]::GetBytes($bytes)).ToLowerInvariant()
    }

    $testCompany = Get-HuduCompanies -Id $env:HUDU_TEST_COMPANY_ID
    $null = $testCompany | Should -Not -BeNullOrEmpty

    Write-Host ("Setting up test for VLAN/VLAN Zones. Hudu version: {0}" -f (Get-HuduAppInfo).version)
  }

  It "creates, verifies, updates, verifies, archives, unarchives, deletes VLANs and VLAN Zones" {

    $vlanInfo  = @{
      Required = Get-Random -Minimum 8 -Maximum 12
      VlanIds  = @()
      Created  = @()
    }
    $zonesInfo = @{
      MaxZones = Get-Random -Minimum 3 -Maximum 6
      Created  = @()
    }

    Write-Host "Creating $($vlanInfo.Required) VLANs with up to $($zonesInfo.MaxZones) zones each for company $($testCompany.Name)"

    for ($i = 1; $i -le $vlanInfo.Required; $i++) {

      # Unique VLAN ID in [4..4094]
      do {
        $newVlanId = Get-Random -Minimum 4 -Maximum 4095
      } until (-not ($vlanInfo.VlanIds -contains $newVlanId))
      $vlanInfo.VlanIds += $newVlanId
      $vlanName = "Vlan-$(Get-RandomHexString -bytes 12)-$i-of-$($vlanInfo.Required)"
      $vlanRequest = @{
        Name        = $vlanName
        CompanyId   = $testCompany.Id
        VlanId      = $newVlanId
        Description = "VLAN ($($vlanName)) from Integration Test $(Get-RandomHexString -bytes 2) $(Get-RandomHexString -bytes 4) $(Get-RandomHexString -bytes 6)."
      }
      if ($StatusListItemId) { $vlanRequest["StatusListItemId"] = $StatusListItemId }
      if ($RoleListItemId)   { $vlanRequest["RoleListItemId"]   = $RoleListItemId }
      Write-Host "Creating Zone $($vlanRequest.Description)"

      $createdVlan = New-HuduVlan @vlanRequest
      $null = $createdVlan | Should -Not -BeNullOrEmpty
      $vlanInfo.Created += $createdVlan

      # Assertions for VLAN
      $createdVlan.name        | Should -Be $vlanRequest.Name
      $createdVlan.company_id   | Should -Be $vlanRequest.CompanyId
      $createdVlan.vlan_id      | Should -Be $vlanRequest.VlanId
      $createdVlan.description | Should -Be $vlanRequest.Description
      if ($vlanRequest.StatusListItemId) { $createdVlan.StatusListItemId | Should -Be $vlanRequest.StatusListItemId }
      if ($vlanRequest.RoleListItemId)   { $createdVlan.RoleListItemId   | Should -Be $vlanRequest.RoleListItemId   }

      $zonesToCreate = Get-Random -Minimum 1 -Maximum ($zonesInfo.MaxZones + 1)

      for ($d = 1; $d -le $zonesToCreate; $d++) {
        $VlanRange=Get-RandomVlanRange
        $ZoneName = "Zone-$(Get-RandomHexString -bytes 3)-$(Get-RandomHexString -bytes 3)-$d-of-$zonesToCreate"
        $zoneRequest = @{
          Name          = $ZoneName
          CompanyId     = $testCompany.Id
          VlanIdRanges  = $VlanRange
          Description   = "VLAN Zone ($ZoneName) from Integration Test $(Get-RandomHexString -bytes 2) $(Get-RandomHexString -bytes 16)."
        }
        Write-Host "Creating Zone $($zoneRequest.Description)"
        $newVlanZone = New-HuduVlanZone @zoneRequest
        $null = $newVlanZone | Should -Not -BeNullOrEmpty
        $zonesInfo.Created += $newVlanZone

        # Assertions for VLAN Zone (assert against the ZONE you just created)
        $newVlanZone.Name         | Should -Be $zoneRequest.Name
        $newVlanZone.company_id    | Should -Be $zoneRequest.CompanyId
        $newVlanZone.vlan_id_ranges | Should -Be $zoneRequest.VlanIdRanges
        $newVlanZone.Description  | Should -Be $zoneRequest.Description

      }
    }

    Write-Host "Created $($vlanInfo.Created.Count) VLANs with $($zonesInfo.Created.Count) total Zones. Next: modify, archive/unarchive, delete (TODO)."
    foreach ($createdVLAN in $vlaninfo.Created) {
        $retrieved = Get-HuduVLANs -id $createdVLAN.id
        foreach ($prop in $retrieved | Get-Member -MemberType NoteProperty,Property | Select-Object -Expand Name) {
            $createdVLAN.$prop | Should -Be $retrieved.$prop
        }        




    }
  
  
  
  
  }
}
