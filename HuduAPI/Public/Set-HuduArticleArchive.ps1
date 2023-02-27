function Set-HuduArticleArchive {
    <#
    .SYNOPSIS
    Archive/Unarchive a Knowledge Base Article

    .DESCRIPTION
    Uses Hudu API to archive or unarchive an article

    .PARAMETER Id
    Id of the requested article

    .PARAMETER Archive
    Boolean for archive status

    .EXAMPLE
    Set-HuduArticleArchive -Id 1 -Archive $true

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,
        [Parameter(Mandatory = $true)]
        [Bool]$Archive
    )

    if ($Archive) {
        $Action = 'archive'
    } else {
        $Action = 'unarchive'
    }

    if ($PSCmdlet.ShouldProcess($Id)) {
        Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$Id/$Action"
    }
}
