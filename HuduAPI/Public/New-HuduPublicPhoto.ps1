function New-HuduPublicPhoto {
    param(
        [Parameter(Mandatory)][string]$FilePath,
        [int]$record_id,
        [string]$record_type
    )

        $form = @{
            photo = Get-item $FilePath
        }

        if ($record_id) {$form['record_id'] = $record_id}
        if ($record_type) {$form['record_type'] = $record_type} 

        $UploadedPhoto = Invoke-HuduRequest -Method POST -Resource "/api/v1/public_photos" -Form $form
			
		return $UploadedPhoto

}
