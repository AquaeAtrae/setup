<<<<<<< HEAD
Write-Host "Installing WSL"
=======
>>>>>>> upstream/master
$winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')
if ($winVer -ge 2004) {
  RefreshEnv
  # wsl 2 rocks 🚀
<<<<<<< HEAD
    wsl --set-default-version 2
}
$item = "wsl-ubuntu-1804"
$file = "$env:TEMP\$item.appx"
Write-Host "Downloading $item"
curl.exe -sL https://aka.ms/$item -o $file
Add-AppxPackage $file
Remove-Item $file

RefreshEnv

Ubuntu1804 install --root
Ubuntu1804 run apt-get update
Ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

Ubuntu1804 run wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
Ubuntu1804 run dpkg -i packages-microsoft-prod.deb
Ubuntu1804 run rm -f packages-microsoft-prod.deb

Ubuntu1804 run apt-get update
Ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https
Ubuntu1804 run apt-get update
Ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt-get install -y dotnet-sdk-3.1 aspnetcore-runtime-3.1 dotnet-runtime-3.1 dotnet-runtime-2.1

# pwsh

Ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt-get install -y powershell-preview
Ubuntu1804 run ln -sf /usr/bin/pwsh-preview /usr/bin/pwsh

# python

Ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-venv python3-pip

# ruby

Ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt-get install -y ruby ruby-dev ruby-bundler zlib1g-dev

# nodejs

Ubuntu1804 run curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
Ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
=======
  wsl --set-default-version 2
}
if (!(Get-Command "ubuntu2004.exe" -ErrorAction SilentlyContinue)) {
  $item = "wslubuntu2004"
  $file = "$env:TEMP\$item.appx"
  Write-Host "Downloading $item"
  curl.exe -sL https://aka.ms/$item -o $file
  Add-AppxPackage $file
  Remove-Item $file

  RefreshEnv

  Ubuntu2004 install --root
  Ubuntu2004 config --default-user root
  Ubuntu2004 run "curl -sL '$helperUri/WSL.sh' | bash"
  Ubuntu2004 run passwd joseph
  Ubuntu2004 config --default-user joseph
}
>>>>>>> upstream/master
