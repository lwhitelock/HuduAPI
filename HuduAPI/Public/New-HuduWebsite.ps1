function New-HuduWebsite {
    <#
    .SYNOPSIS
    Create a Website

    .DESCRIPTION
    Uses Hudu API to create a website

    .PARAMETER Name
    Website name (e.g. https://domain.com)

    .PARAMETER Notes
    Used to add additional notes to a website

    .PARAMETER Paused
    When true, website monitoring is paused

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
    New-HuduWebsite -CompanyId 1 -Name https://domain.com

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [String]$Notes = '',

        [String]$Paused = '',

        [Alias('company_id')]
        [Parameter(Mandatory = $true)]
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

    $Website = [ordered]@{website = [ordered]@{} }

    $Website.website.add('name', $Name)

    if ($Notes) {
        $Website.website.add('notes', $Notes)
    }

    if ($Paused) {
        $Website.website.add('paused', $Paused)
    }

    $Website.website.add('company_id', $CompanyId)

    if ($DisableDNS) {
        $Website.website.add('disable_dns', $DisableDNS)
    }

    if ($DisableSSL) {
        $Website.website.add('disable_ssl', $DisableSSL)
    }

    if ($DisableWhois) {
        $Website.website.add('disable_whois', $DisableWhois)
    }

    if ($Slug) {
        $Website.website.add('slug', $Slug)
    }

    if ($EnableDMARC) {
        $Website.website.add('enable_dmarc_tracking', $EnableDMARC)
    }

    if ($EnableDKIM) {
        $Website.website.add('enable_dkim_tracking', $EnableDKIM)
    }

    if ($EnableSPF) {
        $Website.website.add('enable_spf_tracking', $EnableSPF)
    }

    $JSON = $Website | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($Name)) {
        Invoke-HuduRequest -Method post -Resource '/api/v1/websites' -Body $JSON
    }
}
