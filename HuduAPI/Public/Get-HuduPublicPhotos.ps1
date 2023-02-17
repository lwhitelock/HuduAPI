function Get-HuduPublicPhotos {
	
		$i = 1;
		$AllPublicPhotos = do {
			$PublicPhotos = Invoke-HuduRequest -Method get -Resource "/api/v1/public_photos?page=$i&page_size=1000"
			$i++
			$PublicPhotos.public_photos
		} while ($PublicPhotos.public_photos.count % 1000 -eq 0 -and $PublicPhotos.public_photos.count -ne 0)
		
			
		return $AllPublicPhotos

}
