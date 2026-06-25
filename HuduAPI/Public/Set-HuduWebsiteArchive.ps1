function Set-HuduWebsiteArchive {
    <#
    .SYNOPSIS
    Update a Website to be archived or unarchived

    .PARAMETER Archive
    Boolean of archive status

        .EXAMPLE
    Set-HuduWebsiteArchive -Archive $true -Id 1

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,

        [Parameter(Mandatory = $true)]
        [Alias('Archived')]
        [bool]$Archive
    )
    process {
    
        $Object = Get-HuduWebsites -Id $Id
        if (-not $Object) {
            Throw "Website with Id $Id not found or invalid object returned."
        }


        $Website = [ordered]@{website = $Object }
        $Website.website.archived = $Archive
        
        if ($PSCmdlet.ShouldProcess($Id)) {
            $JSON = $Website | ConvertTo-Json -Depth 10
            Invoke-HuduRequest -Method put -Resource "/api/v1/websites/$Id" -Body $JSON
        }
    }
}