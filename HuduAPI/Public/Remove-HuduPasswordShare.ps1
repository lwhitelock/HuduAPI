function Remove-HuduPasswordShare {
    <#
    .SYNOPSIS
    Delete a sharing link for a password.

    .DESCRIPTION
    Deletes a sharing link, immediately revoking access to the shared password.
    Requires an API key with access to passwords and destructive actions enabled.

    .PARAMETER AssetPasswordId
    ID of the password the sharing link belongs to.

    .PARAMETER Id
    ID of the sharing link to delete. Accepts the id property of sharing link
    objects from the pipeline.

    .EXAMPLE
    Remove-HuduPasswordShare -AssetPasswordId 42 -Id 7

    Revokes sharing link 7 for password 42 after confirmation.

    .EXAMPLE
    Get-HuduPasswordShares -AssetPasswordId 42 | Remove-HuduPasswordShare -AssetPasswordId 42 -WhatIf

    Previews revoking every sharing link for password 42.

    .NOTES
    API Endpoint: DELETE /api/v1/asset_passwords/{asset_password_id}/shares/{id}
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true)]
        [Alias('PasswordId', 'asset_password_id')]
        [ValidateRange(1, [long]::MaxValue)]
        [long]$AssetPasswordId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('ShareId', 'share_id')]
        [ValidateRange(1, [long]::MaxValue)]
        [long]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess("Sharing link ID $Id for password ID $AssetPasswordId", 'Delete sharing link')) {
            Invoke-HuduRequest -Method DELETE -Resource "/api/v1/asset_passwords/$AssetPasswordId/shares/$Id"
        }
    }
}
