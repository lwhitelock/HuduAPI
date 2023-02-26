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

    .PARAMETER Slug
    Url identifier

    .EXAMPLE
    Set-HuduWebsite -Id 1 -Paused $true

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,

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

    $Website.website.add('company_id', $companyid)

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

    $JSON = $Website | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/websites/$Id" -Body $JSON
    }
}