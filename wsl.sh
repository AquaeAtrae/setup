#!/bin/bash
VER=$(lsb_release -sr) # like `18.04`

# dotnet

wget -q https://packages.microsoft.com/config/ubuntu/${VER}/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm -f packages-microsoft-prod.deb

apt update
apt install -y apt-transport-https
apt update
apt install -y dotnet-sdk-3.1 aspnetcore-runtime-3.1 dotnet-runtime-3.1 dotnet-runtime-2.1

# pwsh

apt install -y powershell-preview
ln -sf /usr/bin/pwsh-preview /usr/bin/pwsh

# python
apt install -y python3 python3-venv python3-pip

# gpg

pwsh ./gpg.ps1