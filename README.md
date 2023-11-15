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

## Important Notions
A PowerShell (PS1) script is runned sequentially from the top to the buttom

The naming convention of PowerShell scripts is CamelCase.

Everything is an object in PowerShell.

Always use the `select-object` command to filter object properties before using the `where-object` command to filter property values.

The comparison operators in PowerShell are case insensitive. Add a prefix `c` to make a case sensitive comparison.
Example: -eq is a case insensitve equality. -ceq is a case sensitive equality
- `Equality operators`: -eq, -ne, -gt, -ge, -lt, -le
- `Matching operators`: -like, -notlike, -match, -notmacht
- `Replacement operator`: -replace
- `Containement operators`: -contains, -notcontains, -in, -notin
- `Type operators`: -is, -isnot
- `Logical operators`: -and, -or, -not

## Common Commands

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

# Deletes a variable and its value from the scope in which it is defined, such as the current session
Remove-Variable var1 # Deletes the $var1 variable.

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

If-elseif-else Condition Example
~~~ps1
# Uncomment the following command to see all local users on your system
# Get-LocalUser

$UserName = 'user01' # Set this to a local user existing in your system
# Get the local user object named $UserName
$UserObject = Get-LocalUser -Name $UserName
$UserObject

'Is the user ' + $UserName + ' enabled ? ' + $UserObject.Enabled

# Disable the user user01 if he is enabled
if($UserObject.Enabled -eq $True){
    Disable-LocalUser -InputObject $UserObject
    #Disable-LocalUser -Name $UserObject.Name # option 1
    $UserObject = Get-LocalUser -Name $UserObject.Name # option 2
    'If Is the user ' + $UserName + ' enabled ? ' + $UserObject.Enabled
# Or enable it if it his disabled
} else {
    Enable-LocalUser -InputObject $UserObject
    #Enable-LocalUser -Name $UserObject.Name # option 1
    $UserObject = Get-LocalUser -Name $UserObject.Name # option 2
    'Else Is the user ' + $UserName + ' enabled ? ' + $UserObject.Enabled
}
~~~

## An Overview of PowerShell Commands with equivalent in Windows Batch/CMD or Linux/Mac Batch/Terminal
Display the list of built-in aliases
~~~ps1
Get-Alias
~~~

Export as list of command - alias association sorted alphabetically by command name
~~~ps1
# Save the list in a variable
$builtin_command_aliases = Get-Alias | Select-Object definition, name | Sort-Object -Property definition
# Export the list a csv file in the current directory. Override the the file if it already exists.
$builtin_command_aliases | Export-Csv -Path .\builtin_command_aliases.csv -Delimiter ';' -NoTypeInformation -Force
~~~
|PowerShell Command|Windows Batch/CMD Command|Linux/Mac Bash/Terminal Command|Built-In Alias|
|---|---|---|---|
|Clear-Host|clear|cls||
|Get-ChildItem|dir|ls|gci, Get-Item *|
|Gel-Help|help|man||
|Get-Location||pwd|gl, Get-Item .|
|New-Item -ItemType Directory|md|md, mkdir|ni|
|New-Item -ItemType File|type nul >, echo nul >|touch, cat >, echo >|ni|

|PowerShell Command|Windows Batch/CMD Command|Linux/Mac Bash/Terminal Command|PowerShell Built-In Alias|
|---|---|---|---|
|Add-Content|||ac|
|Add-LocalGroupMember|||algm|
|Add-PSSnapIn|||asnp|
|Clear-Content|||clc|
|Clear-History|||clhy|
|Clear-Host|||cls, clear|
|Clear-Item|||cli|
|Clear-ItemProperty|||clp|
|Clear-Variable|||clv|
|Compare-Object|||compare, diff|
|Connect-PSSession|||cnsn|
|ConvertFrom-String|||CFS|
|Convert-Path|||cvpa|
|Copy-Item|||copy, cp, cpi|
|Copy-ItemProperty|||cpp|
|Disable-LocalUser|||dlu|
|Disable-PSBreakpoint|||dbp|
|Disconnect-PSSession|||dnsn|
|Enable-LocalUser|||elu|
|Enable-PSBreakpoint|||ebp|
|Enter-PSSession|||etsn|
|Exit-PSSession|||exsn|
|Export-Alias|||epal|
|Export-Csv|||epcsv|
|Export-PSSession|||epsn|
|ForEach-Object|||foreach, %|
|Format-Custom|||fc|
|Format-Hex|||fhx|
|Format-List|||fl|
|Format-Table|||ft|
|Format-Wide|||fw|
|Get-Alias|||gal|
|Get-ChildItem|||gci, ls, dir|
|Get-Clipboard|||gcb|
|Get-Command|||gcm|
|Get-ComputerInfo|||gin|
|Get-Content|||type, cat, gc|
|Get-History|||ghy, h, history|
|Get-Item|||gi|
|Get-ItemProperty|||gp|
|Get-ItemPropertyValue|||gpv|
|Get-Job|||gjb|
|Get-LocalGroup|||glg|
|Get-LocalGroupMember|||glgm|
|Get-LocalUser|||glu|
|Get-Location|||gl, pwd|
|Get-Member|||gm|
|Get-Module|||gmo|
|Get-Process|||ps, gps|
|Get-PSBreakpoint|||gbp|
|Get-PSCallStack|||gcs|
|Get-PSDrive|||gdr|
|Get-PSSession|||gsn|
|Get-PSSnapIn|||gsnp|
|Get-Service|||gsv|
|Get-TimeZone|||gtz|
|Get-Unique|||gu|
|Get-Variable|||gv|
|Get-WmiObject|||gwmi|
|Group-Object|||group|
|help|||man|
|Import-Alias|||ipal|
|Import-Csv|||ipcsv|
|Import-Module|||ipmo|
|Import-PSSession|||ipsn|
|Invoke-Command|||icm|
|Invoke-Expression|||iex|
|Invoke-History|||ihy, r|
|Invoke-Item|||ii|
|Invoke-RestMethod|||irm|
|Invoke-WebRequest|||curl, wget, iwr|
|Invoke-WMIMethod|||iwmi|
|Measure-Object|||measure|
|mkdir|||md|
|Move-Item|||mi, move, mv|
|Move-ItemProperty|||mp|
|New-Alias|||nal|
|New-Item|||ni|
|New-LocalGroup|||nlg|
|New-LocalUser|||nlu|
|New-Module|||nmo|
|New-PSDrive|||mount, ndr|
|New-PSSession|||nsn|
|New-PSSessionConfigurationFile|||npssc|
|New-Variable|||nv|
|Out-GridView|||ogv|
|Out-Host|||oh|
|Out-Printer|||lp|
|Pop-Location|||popd|
|powershell_ise.exe|||ise|
|Push-Location|||pushd|
|Receive-Job|||rcjb|
|Receive-PSSession|||rcsn|
|Remove-Item|||erase, rmdir, del, rm, rd, ri|
|Remove-ItemProperty|||rp|
|Remove-Job|||rjb|
|Remove-LocalGroup|||rlg|
|Remove-LocalGroupMember|||rlgm|
|Remove-LocalUser|||rlu|
|Remove-Module|||rmo|
|Remove-PSBreakpoint|||rbp|
|Remove-PSDrive|||rdr|
|Remove-PSSession|||rsn|
|Remove-PSSnapin|||rsnp|
|Remove-Variable|||rv|
|Remove-WMIObject|||rwmi|
|Rename-Item|||rni, ren|
|Rename-ItemProperty|||rnp|
|Rename-LocalGroup|||rnlg|
|Rename-LocalUser|||rnlu|
|Resolve-Path|||rvpa|
|Resume-Job|||rujb|
|Select-Object|||select|
|Select-String|||sls|
|Set-Alias|||sal|
|Set-Clipboard|||scb|
|Set-Content|||sc|
|Set-Item|||si|
|Set-ItemProperty|||sp|
|Set-LocalGroup|||slg|
|Set-LocalUser|||slu|
|Set-Location|||sl, cd chdir|
|Set-PSBreakpoint|||sbp|
|Set-TimeZone|||stz|
|Set-Variable|||sv, set|
|Set-WMIInstance|||swmi|
|Show-Command|||shcm|
|Sort-Object|||sort|
|Start-Job|||sajb|
|Start-Process|||saps, start|
|Start-Service|||sasv|
|Start-Sleep|||sleep|
|Stop-Job|||spjb|
|Stop-Process|||kill, spps|
|Stop-Service|||spsv|
|Suspend-Job|||sujb|
|Tee-Object|||tee|
|Trace-Command|||trcm|
|Wait-Job|||wjb|
|Where-Object|||?, where|
|Write-Output|||echo, write|



