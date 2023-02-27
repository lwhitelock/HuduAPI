function Remove-HuduMagicDash {
    <#
    .SYNOPSIS
    Delete a Magic Dash Item

    .DESCRIPTION
    Uses Hudu API to remove Magic Dash by Id or Title and Company Name

    .PARAMETER Title
    Title of the Magic Dash

    .PARAMETER CompanyName
    Company Name

    .PARAMETER Id
    Id of the Magic Dash

    .EXAMPLE
    Remove-HuduMagicDash -Id 1

    .EXAMPLE
    Remove-HuduMagicDash -Title 'Microsoft 365' -CompanyName 'AcmeCorp'

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High', DefaultParameterSetName = 'Id')]
    Param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, ParameterSetName = 'TitleCompany')]
        [String]$Title,

        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, ParameterSetName = 'TitleCompany')]
        [Alias('company_name')]
        [String]$CompanyName,

        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, ParameterSetName = 'Id')]
        [int]$Id
    )

    process {
        if ($id) {
            if ($PSCmdlet.ShouldProcess($Id)) {
                $null = Invoke-HuduRequest -Method delete -Resource "/api/v1/magic_dash/$Id"
            }
        } else {
            $MagicDash = @{}

            $MagicDash.add('title', $Title)
            $MagicDash.add('company_name', $CompanyName)

            $JSON = $MagicDash | ConvertTo-Json

            if ($PSCmdlet.ShouldProcess("$Company - $Title")) {
                $null = Invoke-HuduRequest -Method delete -Resource '/api/v1/magic_dash' -Body $JSON
            }
        }
    }
}
