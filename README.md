# PowerShell Scripting
PoweShell scripts are used:
- to automate repetitive tasks
- to configure systems and automate administrative tasks
- to build, test and deploy applications.

## PowerShell Environment Setting

Note: I recommend you the PowerShell ISE (Integrated Scripting Environment) to write your scripts because it is built-in editor of Windows 10, 11 and it contains many features such as code completion, git integration.
These features will enhance your productivity. 

### Enable The Execution of Scripts on the system

Know the list of current execution policy of the system
~~~ps1
Get-ExecutionPolicy
~~~

Display the list of executions policies of the system and their corresponding scopes
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

If you see the error massage after pushing your work to GitHub, don't worry 
~~~ps1
+ git push
+ ~~~~~~~~
    + CategoryInfo          : NotSpecified: (To https://gith...l_scripting.git:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
~~~
See a discussion about this essue [here](https://github.com/dahlbyk/posh-git/issues/109)

If Git find a directory unsafe because the current user is not the owner, run this command if you known who owns that directory
~~~ps1
git config --global --add safe.directory C:/Users/admin/powershell_scripting
~~~

## Some Tips and Tricks
A PowerShell (PS1) script is runned sequentially from the top to the buttom

The naming convention of PowerShell scripts is CamelCase

Everything is an object in PowerShell.

Always use the select-object to filter the properties before using the where-object to filger by value

## Some common used commands

Run a script helloWorld.ps1 located in in the current directory
~~~ps1
C:\path\to\current\dir> .\helloWorld.ps1
~~~

Ways to output a message 'Hello World' to the screen
~~~ps1
# Simplest way
'Hello World'

# With an object method
Write-Host 'Hello World'
~~~

Basic variable definition and usage
~~~ps1
$name = 'Foo'
'Hello '+$name
Write-Host 'Hello' $name

# Define a string variable
[String]$var1 = 1
[Int]$var2 = 1

# Display the type of a variable
$var1.getType() 
$var2.getType()
~~~

Handle User Input
~~~ps1
'Please give me your username:'
$username = Read-Host
'Your username is '+$username
'Thank you!' 
~~~

List all the commands installed on the computer, including cmdlets, aliases, functions, filters, scripts, and applications.
~~~ps1
Get-Command
~~~

To see the class and all the members (methods and properties) of an object
~~~ps1
Get-LocalUser | Get-Member
~~~

If-Else Condition Example
~~~ps1
# See all local user on your system
Get-LocalUser

# Get the local user object named user01 - Replace user01 with a localuser existing in your system
$User = Get-LocalUser -Name 'user01'
$User

# Save his current status
$IsEnabled = $User | Select-Object Enabled

'Is the user ' + $User + ' enabled ? ' + $IsEnabled.Enabled

# Disable the user user01 if he is enabled
if($IsEnabled.Enabled -eq $True){
    $User | Disable-LocalUser
    $User = Get-LocalUser -Name 'user01'
    $IsEnabled = $User | Select-Object Enabled
    'If Is the user ' + $User + ' enabled ? ' + $IsEnabled.Enabled
# Or enable it if it his disabled
} else {
    $User | Enable-LocalUser
    $User = Get-LocalUser -Name 'user01'
    $IsEnabled = $User | Select-Object Enabled
    'Else Is the user ' + $User + ' enabled ? ' + $IsEnabled.Enabled
}
~~~

## An Overview of PowerShell Commands with equivalent in Windows Batch/CMD or Linux/Mac Batch/Terminal
|PowerShell Command|Windows Batch/CMD Command|Linux/Mac Bash/Terminal Command|PowerShell Alias|
|---|---|---|---|
|Clear-Host|clear|cls||
|Get-ChildItem|dir|ls|gci, Get-Item *|
|Gel-Help|help|man||
|Get-Location||pwd|gl, Get-Item .|
|New-Item -ItemType Directory|md|md, mkdir|ni|
|New-Item -ItemType File|type nul >, echo nul >|touch, cat >, echo >|ni|

