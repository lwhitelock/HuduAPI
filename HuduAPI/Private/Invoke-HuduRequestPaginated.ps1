function Invoke-HuduRequestPaginated {
    <#
    .SYNOPSIS
    Paginated requests to Hudu API

    .DESCRIPTION
    Wraps Invoke-HuduRequest with page sizes

    .PARAMETER HuduRequest
    Request to paginate

    .PARAMETER Property
    Property name to return (don't specify to return entire response object)

    .PARAMETER PageSize
    Number of results to return per page (default 1000)

    #>
    [CmdletBinding()]
    Param(
        [hashtable]$HuduRequest,
        [string]$Property,
        [int]$PageSize = 1000
    )

    $i = 1
    do {
        $HuduRequest.Params.page = $i
        $HuduRequest.Params.page_size = $PageSize
        $Response = Invoke-HuduRequest @HuduRequest
        $i++
        if ($Property) {
            $Response.$Property
        }

        else {
            $Response
        }
    } while (($Property -and $Response.$Property.count % $PageSize -eq 0 -and $Response.$Property.count -ne 0) -or (!$Property -and $Response.count % $PageSize -eq 0 -and $Response.count -ne 0))
}
