# https://git-scm.com/book/de/v2/Anhang-A%3A-Git-in-anderen-Umgebungen-Git-in-PowerShell

write-host "Install winget tool if you don't already have it, then type this command in command prompt or Powershell."
winget install --id Git.Git -e --source winget

Install-Module posh-git -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force

Import-Module posh-git
Add-PoshGitToProfile -AllHosts

write-host "`nSetting the default global email and the name of the git user..." 
git config --global user.email "djomo.moungoue@hotmail.com"
git config --global user.name "djomo.moungoue"