# https://aka.ms/wsl2kernel
# https://devblogs.microsoft.com/commandline/wsl2-will-be-generally-available-in-windows-10-version-2004/

$ErrorActionPreference = 'Stop'
$packageName = 'wsl2kernel'
$url            = 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'
$checksum       = 'F4833159D00077E160C4B87CA4C4066DA0B20BEC69331CD414A6CB62BD88DE70'   # Get-FileHash -Path "path\to\file" -Algorithm SHA256

$WslPackageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256' 
}

# Install-ChocolateyPackage @WslPackageArgs

Start-Process msiexec.exe -Wait -ArgumentList '/I @WslPackageArgs.url /quiet /qn /norestart'
