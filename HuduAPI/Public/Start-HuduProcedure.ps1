function Start-HuduProcedure {
    <#
    .SYNOPSIS
    Kickoff a procedure as a live process instance

    .DESCRIPTION
    Starts a new process instance from a template or existing procedure.
    Optionally associates the process with an asset or renames it.

    .PARAMETER Id
    ID of the procedure to kickoff

    .PARAMETER AssetId
    Optional asset ID to attach the new process to

    .PARAMETER Name
    Optional new name for the kicked off procedure instance

    .EXAMPLE
    Kickoff-HuduProcedure -Id 42 -AssetId 1001 -Name "Quarterly Maintenance Run"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [int]$Id,
        [int]$AssetId,
        [string]$Name
    )

    $params = @{}
    if ($AssetId) { $params.asset_id = $AssetId }
    if ($Name)    { $params.name     = $Name }

    try {
        $res = Invoke-HuduRequest -Method POST -Resource "/api/v1/procedures/$Id/kickoff" -Params $params
        return $res
    } catch {
        Write-Warning "Failed to kickoff procedure ID $Id"
        return $null
    }
}
