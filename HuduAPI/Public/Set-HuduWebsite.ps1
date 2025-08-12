function Set-HuduWebsite {
    <#
    .SYNOPSIS
    Update a Website

    .DESCRIPTION
    Uses Hudu API to update a website

    .PARAMETER Id
    Id of requested website

    .PARAMETER Name
    Website name (e.g. https://example.com)

    .PARAMETER Notes
    Website Notes

    .PARAMETER Paused
    When true, website monitoring is paused.

    .PARAMETER CompanyId
    Used to associate website with company

    .PARAMETER DisableDNS
    When true, dns monitoring is paused.

    .PARAMETER DisableSSL
    When true, ssl cert monitoring is paused.

    .PARAMETER DisableWhois
    When true, whois monitoring is paused.

    .PARAMETER EnableDMARC
    When true, DMARC monitoring is enabled.
    
    .PARAMETER EnableDKIM
    When true, DKIM monitoring is enabled.
    
    .PARAMETER EnableSPF
    When true, SPF monitoring is enabled.

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    Set-HuduWebsite -Id 1 -Paused $true

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,

        [Parameter()]
        [String]$Name,

        [String]$Notes = '',

        [String]$Paused = '',

        [Alias('company_id')]
        [Parameter()]
        [Int]$CompanyId,

        [Alias('disable_dns')]
        [String]$DisableDNS = '',

        [Alias('disable_ssl')]
        [String]$DisableSSL = '',

        [Alias('disable_whois')]
        [String]$DisableWhois = '',

        [Alias('enable_dmarc')]
        [String]$EnableDMARC = '',

        [Alias('enable_dkim')]
        [String]$EnableDKIM = '',

        [Alias('enable_spf')]
        [String]$EnableSPF = '',

        [string]$Slug
    )
    
    $Object = Get-HuduWebsites -Id $Id
    if (-not $Object) {
        Throw "Website with Id $Id not found or invalid object returned."
    }
    $Website = [ordered]@{website = $Object }

    If ($Name) {
        $Website.website.name = $Name
    }

    if ($Notes) {
        $Website.website.notes = $Notes
    }

    if ($Paused) {
        $Website.website.paused = $Paused
    }

    if ($CompanyId) {
        $Website.website.company_id = $companyid
    }

    if ($DisableDNS) {
        $Website.website.disable_dns = $DisableDNS
    }

    if ($DisableSSL) {
        $Website.website.disable_ssl = $DisableSSL
    }

    if ($DisableWhois) {
        $Website.website.disable_whois = $DisableWhois
    }

    if ($Slug) {
        $Website.website.slug = $Slug
    }

    if ($EnableDMARC) {
        $Website.website.enable_dmarc_tracking = $EnableDMARC
    }

    if ($EnableDKIM) {
        $Website.website.enable_dkim_tracking = $EnableDKIM
    }

    if ($EnableSPF) {
        $Website.website.enable_spf_tracking = $EnableSPF
    }

    $JSON = $Website | ConvertTo-Json -Depth 10

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/websites/$Id" -Body $JSON
    }
}