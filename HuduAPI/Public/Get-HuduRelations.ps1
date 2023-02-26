function Get-HuduRelations {
    <#
    .SYNOPSIS
    Get a list of all relations

    .DESCRIPTION
    Calls Hudu API to retrieve object relationsihps

    .EXAMPLE
    Get-HuduRelations -CompanyId 1

    #>
    [CmdletBinding()]
    Param()

    $HuduRequest = @{
        Method   = 'GET'
        Resource = '/api/v1/relations'
        Params   = @{}
    }

    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'relations'
}
