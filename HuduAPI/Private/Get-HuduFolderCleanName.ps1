function Get-HuduFolderCleanName {
    [CmdletBinding()]
    param(
        [string]$Name
    )

    $FieldNames = @("id", "company_id", "icon", "description", "name", "parent_folder_id", "created_at", "updated_at")

    if ($Name -in $FieldNames) {
        Return "fld_$Name"
    } else {
        Return $Name
    }

}