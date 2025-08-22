function Start-HuduS3Export {
    try {
        Invoke-HuduRequest -Method POST -Resource "/api/v1/s3_exports"
    } catch {
        Write-Warning "Failed to initiate S3 Export- $_"
    }
}
