# install chocolatey to manage package
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install intellijidea-ultimate -y
choco install vscode -y

# setup wsl2
wsl --set-default-version 2
wsl --set-version 2
wsl --install --distribution Ubuntu-22.04