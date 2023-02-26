function Remove-HuduArticle {
    <#
    .SYNOPSIS
    Delete a Knowledge Base Article

    .DESCRIPTION
    Uses Hudu API to remove a KB article

    .PARAMETER Id
    Id of the requested article

    .EXAMPLE
    Remove-HuduArticle -Id 1

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id
    )
    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            Invoke-HuduRequest -Method delete -Resource "/api/v1/articles/$Id"
        }
    }
}
