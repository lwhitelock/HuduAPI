function Start-HuduS3Export {
    <#
    .SYNOPSIS
    Initiate an S3 Backup of Hudu Data (credentials must be configured in settings)

    .DESCRIPTION
    Kicks off a backup in S3 if you have configured Hudu to do this (if so, backs up every Sunday)
    #>    
    try {
        Invoke-HuduRequest -Method POST -Resource "/api/v1/s3_exports"
    } catch {
        Write-Warning "Failed to initiate S3 Export- $_"
    }
}
