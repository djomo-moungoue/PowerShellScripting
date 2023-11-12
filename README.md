# PowerShell Scripting

## PowerShell Environment Setting

### Enable The Execution of Scrits

Display the list of current execution policy
~~~ps1
Get-ExecutionPolicy -list
~~~

If you have admin priviledges on the computer. All users of the computer will able to execute scripts. If a dialog box pop-up, choose "yes, all".
~~~ps1
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine  
~~~

If you have no admin priviledge on the computer. The current user will be able to execute scripts. If a dialog box pop-up, choose "yes, all".
~~~ps1
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser  
~~~

If you have no admin priviledge on the computer and you want to execute scripts on the current PowerShell session. If a dialog box pop-up, choose "yes, all".
~~~ps1
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process  
~~~

More details about the ExecutionPolicy [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-executionpolicy?view=powershell-7.3)

### Set-Up Git Version Control System

~~~ps1
write-host "Install winget tool if you don't already have it, then type this command in command prompt or Powershell."
winget install --id Git.Git -e --source winget

Install-Module posh-git -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force

Import-Module posh-git
Add-PoshGitToProfile -AllHosts

write-host "`nSetting the default global email and the name of the git user..." 
git config --global user.email "git_user_email"
git config --global user.name "git_user_name"
~~~

More details about Git-setup in PowerShell [here](https://git-scm.com/book/de/v2/Anhang-A%3A-Git-in-anderen-Umgebungen-Git-in-PowerShell)