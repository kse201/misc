Set-ExecutionPolicy RemoteSigned
.\proxy.ps1
set ChocolateyInstall=C:\ProgramData\chocolatey
Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
