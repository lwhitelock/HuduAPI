function Set-HuduArticleUnPinned {
    <#
    .SYNOPSIS
    UnPins a Knowledge Base Article from the top of the list
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [Int]$Id
    )
    process {
        if ($PSCmdlet.ShouldProcess($Id)) {
            $result = Invoke-HuduRequest -Method put -Resource "/api/v1/articles/$Id/unpin"
            $result = $result.article ?? $result
            return $result
        }
    }
}
