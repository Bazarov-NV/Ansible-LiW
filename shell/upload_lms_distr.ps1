# Define FTP server details and file paths
$ftpServer = "ftp://46.8.19.212/lmserver/"
$ftpUsername = "user725600"
$ftpPassword = "Ta02pAYGtCuN"
$localFilePath = Resolve-Path -Path ".\lmserver_distr.7z"
#$localFilePath = "d:\work\devops\lmserver_distr.7z"
$remoteFileName = "lmserver_distr.7z" # Name of the file on the FTP server

# Create a new WebClient object
$webClient = New-Object System.Net.WebClient

# Set credentials for authentication
$webClient.Credentials = New-Object System.Net.NetworkCredential($ftpUsername, $ftpPassword)

# Construct the full URI for the remote file
$uri = New-Object System.Uri($ftpServer+$remoteFileName)

# Upload the file
try {
    $webClient.UploadFile($uri, $localFilePath)
    Write-Host "File '$localFilePath' uploaded successfully to '$ftpServer+$remoteFileName'."
}
catch {
    Write-Error "Error uploading file: $($_.Exception.Message)"
}
finally {
    # Dispose the WebClient object
    $webClient.Dispose()
}

