function Get-HuduIPAddresses {
    <#
    .SYNOPSIS
    Get a list of Hudu IP addresses
    #>
    [CmdletBinding()]
    param(
        [int]$Id,
        [string]$Address,
        [string]$Status,
        [string]$FQDN,
        [int]$AssetID,
        [int]$CompanyID,
        [datetime]$CreatedAfter,
        [datetime]$CreatedBefore,
        [datetime]$UpdatedAfter,
        [datetime]$UpdatedBefore        
    )
    $Params = @{}
    if ($NetworkId){$params["network_id"]=$NetworkId}
    if ($Address){$params["address"]=$Address}
    if ($Status){$params["status"]=$Status}
    if ($FQDN){$params["fqdn"]=$FQDN}
    if ($AssetID){$params["asset_id"]=$AssetID}
    if ($CompanyID){$params["company_id"]=$CompanyID}

    $createdRange = Convert-ToHuduDateRange -Start $CreatedAfter -End $CreatedBefore
    if ($createdRange -ne ',' -and -$null -ne $createdRange) {
        $Params.created_at = $createdRange
    }

    $updatedRange = Convert-ToHuduDateRange -Start $UpdatedAfter -End $UpdatedBefore
    if ($updatedRange -ne ',' -and -$null -ne $updatedRange) {
        $Params.updated_at = $updatedRange
    }
    $HuduRequest = if ($Id) {
        @{
            Method   = 'GET'
            Resource = "/api/v1/ip_addresses/$Id"
        }
    } else {
        @{
            Method   = 'GET'
            Resource = "/api/v1/ip_addresses"
            Params   = if ($Params.Count -gt 0) { $Params } else { $null }
        }
    }

    $addresses = Invoke-HuduRequest @HuduRequest

    return $addresses
}
