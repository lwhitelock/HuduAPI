function Get-HuduUploads {
    <#
    .SYNOPSIS
    Get a list of uploads

    .DESCRIPTION
    Calls Hudu API to retrieve uploads

    .EXAMPLE
    Get-HuduUploads

    #>
    [CmdletBinding()]
    Param(
        [Int]$Id
    )

    if ($Id) {
        $Upload = Invoke-HuduRequest -Method Get -Resource "/api/v1/uploads/$Id"
    } else {
        $Upload = Invoke-HuduRequest -Method Get -Resource "/api/v1/uploads"
    }
    return $Upload
}
