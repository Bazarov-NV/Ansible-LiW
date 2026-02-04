# Define the path to the 7z.exe executable
$pathTo7zExe = "C:\Program Files\7-Zip\7z.exe" # Adjust this path if 7-Zip is installed elsewhere

# Define the source directory or file(s) to be archived
$sourcePath = "\\server\АНТОР\Отдел Внедрения\Релизы\LMServer\A1\*" # Or a specific file like "C:\Path\To\Your\File.txt"

# Define the destination path and filename for the 7z archive
$archivePath = ".\lmserver_distr.7z"

# Define 7-Zip command-line arguments
# 'a' for Add to archive
# '-t7z' for 7z archive type
# '-mx=9' for Ultra compression (optional, adjust as needed)
# '-r' for Recurse subdirectories (if archiving a folder)
$arguments = "a", "-t7z", "-mx=9", "$archivePath", "$sourcePath", "-r"

# Invoke the 7z.exe executable with the defined arguments
& $pathTo7zExe $arguments

Write-Host "7z archive created at: $archivePath"

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
    Write-Host "File '$localFilePath' uploaded successfully to '$ftpServer$remoteFileName'."
}
catch {
    Write-Error "Error uploading file: $($_.Exception.Message)"
}
finally {
    # Dispose the WebClient object
    $webClient.Dispose()
}
