function Get-HuduLists {
    <#
    .SYNOPSIS
    Get a list of Lists

    .DESCRIPTION
    Call Hudu API to retrieve Lists for server

    .PARAMETER Name
    Filter by name of  List

    .PARAMETER ListId
    Id of  List

    .PARAMETER Query
    Filter by query

    .EXAMPLE
    Get-HuduLists -Name 'Contacts'

    #>
    [CmdletBinding()]
    Param (
        [String]$Name,
        [Alias('id', 'List_id')]
        [int]$ListId,
        [String]$Query
    )

    $HuduRequest = @{
        Resource = '/api/v1/lists'
        Method   = 'GET'
    }

    if ($ListId) {
        $HuduRequest.Resource = '{0}/{1}' -f $HuduRequest.Resource, $ListId
        $List = Invoke-HuduRequest @HuduRequest
        return $List
    } else {
        $Params = @{}
        if ($Name) { $Params.name = $Name }
        if ($Query) { $Params.query = $Query }
        $HuduRequest.Params = $Params

        $List = Invoke-HuduRequest @HuduRequest

        if (!$Name -and !$Query) {
            $script:AssetList = $List | Sort-Object -Property name
        }
        $List
    }
}