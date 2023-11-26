# PowerShell Scripting
Use PoweShell scripts:
- to automate repetitive/administrative tasks
- to configure systems
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
git config --global user.email "GitUserEmail"
git config --global user.name "GitUserName"
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

The naming convention of PowerShell scripts is:
- CamelCase for variables and methods. Ex: NewUsersFromCsv, GetType()
- Camel-Case for type names. Ex: Get-LocalUser, Import-Csv

Everything is an object in PowerShell.

Always use the `Select-Object` command to filter object properties before using the `where-object` command to filter property values.

The comparison operators in PowerShell are case insensitive. Add a prefix `c` to make a case sensitive comparison.
Example: -eq is a case insensitve equality. -ceq is a case sensitive equality
- `Equality operators`: -eq, -ne, -gt, -ge, -lt, -le
- `Matching operators`: -like, -notlike, -match, -notmacht
- `Replacement operator`: -replace
- `Containement operators`: -contains, -notcontains, -in, -notin
- `Type operators`: -is, -isnot
- `Logical operators`: -and, -or, -not

When you work with the Get-Date object, pay attention of the system settings if the system language and region is not English
~~~ps1
$UFormat = Get-Date -UFormat "%A %m/%d/%Y %R %Z"
"Current Date in UFormat: " + $UFormat
$DayOfWeek1 = Get-Date -Format "dddd" # German
"Current Day of Week (System Language DE) .NetFormat: "+$DayOfWeek1
$DayOfWeek2 = Get-Date -UFormat "%A" # German
"Current Day of Week (System Language DE) UFormat: "+$DayOfWeek2
$CurrentDate = Get-Date # German
$DayOfWeek = $CurrentDate.DayOfWeek # English
"Current Day of Week: "+$DayOfWeek

<# OUTPUT
Current Date in .Net Format: Donnerstag 11.16.2023 07:57 +01:00
Current Date in UFormat: Donnerstag 11/16/2023 08:00 +01
Current Day of Week (System Language DE) .NetFormat: Donnerstag
Current Day of Week (System Language DE) UFormat: Donnerstag
Current Day of Week: Thursday
#>
~~~

Work with PowerShell Arrays
~~~ps1
# Declare the an empty rray
$EmptyArray = @()
'EmptyArray: '+$EmptyArray

# Declare an non empty Array
$NonEmptyArray = @('Zero')
'NonEmptyArray: '+$NonEmptyArray

$EmptyArray = $EmptyArray + 'First'
$EmptyArray += 'Second'
'EmptyArray after assignment: '+$EmptyArray

$NonEmptyArray += 'Third'
'NonEmptyArray after assignment: '+$NonEmptyArray

<# OUTPUT
EmptyArray: 
NonEmptyArray: Zero
EmptyArray after assignment: First Second
NonEmptyArray after assignment: Zero Third
#>
~~~

To concatenate Integer and String, enclose the integer into quotes
~~~ps1
$Array = @()
$Array = $Array + 'First'
$Array += 'Second'
$Array += 'Third'

[Int]$Count = 0

foreach($Item in $Array)
{
    "$Count"+". "+$Item # Int enclosed in quotes
    $Item+". "+$Count # Int not enclosed in quotes
    $count +=1
}
<# OUTPUT
0. First
First. 0
1. Second
Second. 1
2. Third
Third. 2
#>
~~~

A PowerShell Object is an Array of properties. Illustration
~~~ps1
$LocalUsers = Get-LocalUser
$LocalUsers.getType()
"First user: "
$LocalUsers[0] | Format-Table
"First user name: "+ $LocalUsers[0].Name
"First user enabled? "+ $LocalUsers[0].Enabled
"Last user: "
$LocalUsers[-1] | Format-Table
"Last user name: "+ $LocalUsers[-1].Name
"Last user enabled? "+ $LocalUsers[-1].Enabled

IsPublic IsSerial Name                                     BaseType                                                                                                                  
-------- -------- ----                                     --------                                                                                                                  
True     True     Object[]                                 System.Array                                                                                                              

First user: 
Name  Enabled Description    
----  ------- -----------    
admin True    Enabled account
First user name: admin
First user enabled? True

Last user: 
Name Enabled Description    
---- ------- -----------    
x    True    Enabled account
Last user name: x
Last user enabled? True
#>
~~~

The Import-Csv command enable you to have a object identical to a PowerShell Object.
~~~ps1
$UsersFromCsvObject = Import-csv -Path "C:\Users\admin\powershell_scripting\users.csv"
$UsersFromCsvObject.GetType()
$UsersFromCsvObject | Format-Table

<# OUTPUT
IsPublic IsSerial Name                                     BaseType                                                                                                                  
-------- -------- ----                                     --------                                                                                                                  
True     True     Object[]                                 System.Array 

LOGONNAME PASSWORDOFUSER DESCRIPTION
--------- -------------- -----------
user06    Pa55w.rd       Sales      
user07    Pa55w.rd       Support    
user08    Pa55w.rd       Managers  
#> 
~~~

The `Measure-Object` cmdlet performs calculations on the property values of objects. 
- You can use `Measure-Object` to count objects or count objects with a specified Property . 
- You can also use `Measure-Object` to calculate the Minimum , Maximum , Sum , StandardDeviation and Average of numeric values. 
- For String objects, you can also use `Measure-Object` to count the number of lines, words, and characters.

More about Measure-Object [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object?view=powershell-7.4)

Use Import-csv and Measure-Object to create new local users from a CSV file if they not exists.
~~~ps1
<#
Create a PowerShell script which will import these users locally. 
- Make sure that these users are able to login. 
- Also make sure that the department header in the CSV file will be the description property of the new localuser.
#>
Clear-Host

# Import the Csv file content as .Net object
$NewPersonals = Import-Csv -Path "C:\Users\admin\powershell_scripting\new_personal.csv"
$LocalUserNames = Get-LocalUser | Select-Object -ExpandProperty Name

# Iterate through the list of users
foreach($NewPersonal in $NewPersonals)
{
    if($NewPersonal.LOGINNAME -notin $LocalUserNames)
    {
        # Secure the user password
        $SecurePassword = ConvertTo-SecureString $NewPersonal.PASSWORD -AsPlainText -Force

        # Create a local user account
        $NewLocalUser = New-LocalUser -Name $NewPersonal.LOGINNAME -FullName $NewPersonal.NAME -Password $SecurePassword -Description $NewPersonal.DEPARTMENT

        # Add the user account to a local group Users so that he will be able to login
        Add-LocalGroupMember -Group "Benutzer" -Member $NewLocalUser.Name
        # Display the Users
        Get-LocalGroupMember -Group Benutzer

        # Delete a local user
        # Get-LocalUser | Where-Object {$_.Name -in ($NewLocalUser.Name)} | Remove-LocalUser
    }
}
~~~

Get-Verb. Running this command returns a list of verbs that most commands adhere to. The response includes a description of what these verbs do. Since most commands follow this naming convention, it sets expectations on what a command does. This helps you select the appropriate command and what to name a command, should you be creating one.

Get-Command. This command retrieves a list of all commands installed on your machine.

Get-Member. It operates on object based output and is able to discover what object, properties and methods are available for a command.

Get-Help. Invoking this command with the name of a command as an argument displays a help page describing various parts of a command.

## Common Commands

Run a script helloWorld.ps1 located in in the current directory
~~~ps1
C:\path\to\current\dir> .\helloWorld.ps1
~~~

Open a file in PowerShell ISE from the PowerShell command line
~~~ps1
C:\path\to\current\dir> powershell_ise.exe .\helloWorld.ps1
~~~
Open a file with his default application from the PowerShell command line
~~~ps1
C:\path\to\current\dir> Invoke-Item .\helloWorld.ps1
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
# All commands
Get-Command

# Commands conaining the verb "Get"
Get-Command -Verb "Get*"

# Commands containing the noun "User"
Get-Command -Noun "*User*"
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

## PowerShell - Windows Batch - Linux/Mac Bash/Shell Commands
Tis section describes common Windows PowerShell Commands with their equivalent Windows Batch Commands or Linux/Mac Bash/Shell Commands.

Display the list of built-in aliases
~~~ps1
Get-Alias
~~~

Export a list of command - alias associations sorted alphabetically by the command definition
~~~ps1
# Save the list in a variable
$builtin_command_aliases = Get-Alias | Select-Object definition, name | Sort-Object -Property definition
# Export the list a csv file in the current directory. Override the the file if it already exists.
$builtin_command_aliases | Export-Csv -Path .\builtin_command_aliases.csv -Delimiter ';' -NoTypeInformation -Force
~~~

Display the aliases of a cmdlet. 
~~~ps1
# Example of: Get-ChildItem
Get-Alias -Definition Get-ChildItem

<# OUTPUT
CommandType     Name                                               Version    Source                                                                                                 
-----------     ----                                               -------    ------                                                                                                 
Alias           dir -> Get-ChildItem                                                                                                                                                 
Alias           gci -> Get-ChildItem                                                                                                                                                 
Alias           ls -> Get-ChildItem  
#>
~~~

|PowerShell Command|Batch Command|Bash/Shell Command|PowerShell Built-In Alias|PowerShell Command Description|
|---|---|---|---|---|
|Add-Content|||ac||
|Add-LocalGroupMember|||algm||
|Add-PSSnapIn|||asnp||
|Clear-Content|||clc||
|Clear-History|||clhy||
|Clear-Host|clear|cls|cls, clear||
|Clear-Item|||cli||
|Clear-ItemProperty|||clp||
|Clear-Variable|||clv||
|Compare-Object||diff|compare, diff||
|Connect-PSSession|||cnsn||
|ConvertFrom-String|||CFS||
|Convert-Path|||cvpa||
|Copy-Item|copy|cp|copy, cp, cpi||
|Copy-ItemProperty|||cpp||
|Disable-LocalUser|||dlu||
|Disable-PSBreakpoint|||dbp||
|Disconnect-PSSession|||dnsn||
|Enable-LocalUser|||elu||
|Enable-PSBreakpoint|||ebp||
|Enter-PSSession|||etsn||
|Exit-PSSession|||exsn||
|Export-Alias|||epal||
|Export-Csv|||epcsv||
|Export-PSSession|||epsn||
|ForEach-Object|||foreach, %||
|Format-Custom|||fc||
|Format-Hex|||fhx||
|Format-List|||fl||
|Format-Table|||ft||
|Format-Wide|||fw||
|Get-Alias|||gal||
|Get-ChildItem|dir|ls|gci, ls, dir||
|Get-Clipboard|||gcb||
|Get-Command|||gcm||
|Get-ComputerInfo|systeminfo||gin||
|Get-Content|type|cat|type, cat, gc||
|Get-Help|help|man|help, man||
|Get-History||history|ghy, h, history||
|Get-Item|||gi||
|Get-ItemProperty|||gp||
|Get-ItemPropertyValue|||gpv||
|Get-Job|||gjb||
|Get-LocalGroup|||glg||
|Get-LocalGroupMember|||glgm||
|Get-LocalUser|||glu||
|Get-Location||pwd|gl, pwd||
|Get-Member|||gm||
|Get-Module|||gmo||
|Get-Process||ps|ps, gps||
|Get-PSBreakpoint|||gbp||
|Get-PSCallStack|||gcs||
|Get-PSDrive|||gdr||
|Get-PSSession|||gsn||
|Get-PSSnapIn|||gsnp||
|Get-Service|||gsv||
|Get-TimeZone|||gtz||
|Get-Unique|||gu||
|Get-Variable|||gv||
|Get-WmiObject|||gwmi||
|Group-Object|||group||
|Import-Alias|||ipal||
|Import-Csv|||ipcsv||
|Import-Module|||ipmo||
|Import-PSSession|||ipsn||
|Invoke-Command|||icm||
|Invoke-Expression|||iex||
|Invoke-History|||ihy, r||
|Invoke-Item|||ii|Performs the default action on the specified item.|
|Invoke-RestMethod|||irm||
|Invoke-WebRequest||curl, wget|curl, wget, iwr||
|Invoke-WMIMethod|||iwmi||
|Measure-Object|||measure||
|mkdir||mkdir|md||
|Move-Item|||mi, move, mv||
|Move-ItemProperty|||mp||
|New-Alias|||nal||
|New-Item|||ni||
|New-Item -ItemType Directory|md|md, mkdir|ni||
|New-Item -ItemType File|type nul >, echo nul >|touch, cat >, echo >|ni||
|New-LocalGroup|||nlg||
|New-LocalUser|||nlu||
|New-Module|||nmo||
|New-PSDrive||mount|mount, ndr||
|New-PSSession|||nsn||
|New-PSSessionConfigurationFile|||npssc||
|New-Variable|||nv||
|Out-GridView|||ogv||
|Out-Host|||oh||
|Out-Printer|||lp||
|Pop-Location|||popd||
|powershell_ise.exe|||ise||
|Push-Location|||pushd||
|Receive-Job|||rcjb||
|Receive-PSSession|||rcsn||
|Remove-Item|del|rmdir, rm|erase, rmdir, del, rm, rd, ri||
|Remove-ItemProperty|||rp||
|Remove-Job|||rjb||
|Remove-LocalGroup|||rlg||
|Remove-LocalGroupMember|||rlgm||
|Remove-LocalUser|||rlu||
|Remove-Module|||rmo||
|Remove-PSBreakpoint|||rbp||
|Remove-PSDrive|||rdr||
|Remove-PSSession|||rsn||
|Remove-PSSnapin|||rsnp||
|Remove-Variable|||rv||
|Remove-WMIObject|||rwmi||
|Rename-Item|||rni, ren|Renames an item in a PowerShell provider namespace.|
|Rename-ItemProperty|||rnp||
|Rename-LocalGroup|||rnlg||
|Rename-LocalUser|||rnlu||
|Resolve-Path|||rvpa||
|Resume-Job|||rujb||
|Select-Object|||select||
|Select-String|||sls||
|Set-Alias|||sal||
|Set-Clipboard|||scb||
|Set-Content|||sc||
|Set-Item|||si||
|Set-ItemProperty|||sp||
|Set-LocalGroup|||slg||
|Set-LocalUser|||slu||
|Set-Location||cd|sl, cd chdir||
|Set-PSBreakpoint|||sbp||
|Set-TimeZone|||stz||
|Set-Variable|||sv, set||
|Set-WMIInstance|||swmi||
|Show-Command|||shcm||
|Sort-Object|||sort||
|Start-Job|||sajb||
|Start-Process|||saps, start||
|Start-Service|||sasv||
|Start-Sleep|||sleep||
|Stop-Job|||spjb||
|Stop-Process||kill|kill, spps||
|Stop-Service|||spsv||
|Suspend-Job|||sujb||
|Tee-Object|||tee||
|Trace-Command|||trcm||
|Wait-Job|||wjb||
|Where-Object|||?, where||
|Write-Output|echo||echo, write||

## Useful resources
- https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.4
- https://learn.microsoft.com/en-us/shows/browse?terms=powershell
- https://learn.microsoft.com/en-us/training/browse/?terms=PowerShell
- https://learn.microsoft.com/en-us/powershell/scripting/discover-powershell?view=powershell-7.4
- https://learn.microsoft.com/en-us/powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7?view=powershell-7.4

# Appendix

# Setup your Environment to access Windows Active Directory and Remote Desktops using PowerShel scripts

First make sure your Windows Version has these Hyper-V requirements enabled
~~~ps1
Get-ComputerInfo
<# OUTPUT
...
HyperVisorPresent                                       : True
HyperVRequirementDataExecutionPreventionAvailable       : True
HyperVRequirementSecondLevelAddressTranslation          : True
HyperVRequirementVirtualizationFirmwareEnabled          : True
HyperVRequirementVMMonitorModeExtensions                : True
#>
~~~

Enable Windows-Feature "Hyper-V" by looking up "Windows-Features on/off" via the Windows search field. NB: Your computer must be restarted so that the settings take effect.
~~~ps1
Get-ComputerInfo
<# OUTPUT
...
HyperVisorPresent                                       : True
HyperVRequirementDataExecutionPreventionAvailable       : 
HyperVRequirementSecondLevelAddressTranslation          : 
HyperVRequirementVirtualizationFirmwareEnabled          : 
HyperVRequirementVMMonitorModeExtensions                : 
#>
~~~


