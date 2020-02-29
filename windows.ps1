#Requires -RunAsAdministrator

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# enable TLS 1.2 on 64 bit .Net Framework
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v2.0.50727' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v2.0.50727' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord

# enable TLS 1.2 on 32 bit .Net Framework
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord

.\debloat.ps1

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# $winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')

# gpg home dir should be inside userprofile, otherwise git will have a field day 😅
[Environment]::SetEnvironmentVariable("GNUPGHOME", "%USERPROFILE%\.gnupg", "Machine")

.\features.ps1

choco feature enable -n allowGlobalConfirmation

scoop bucket add extras
scoop bucket add nerd-fonts

choco install chocolatey-core.extension vcredist2015 googlechrome vscode.install powershell-preview
choco install dotnetcore-sdk --version=2.1.804 --side-by-side
choco install dotnetcore-sdk --version=3.1.102 --side-by-side

scoop install git gpg4win greenshot gsudo hub jetbrains-mono rapidee slack jetbrains-toolbox nodejs python

.\gpg.ps1
