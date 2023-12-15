# See some usage examples of a command
get-help get-localuser -Examples

# Display the help with detailed or full parameter description
get-help get-localuser -detailed
get-help get-localuser -full

# List all the commands installed on the computer, including cmdlets, aliases, functions, filters, scripts, and applications.
Get-Command

get-localuser gast | Disable-LocalUser

clear-host cls

# retrieve all the files in a directory
get-childitem # aliases: gci ls dir

# Retrieve the current directory
get-item .
# Get all the items in the current directory
get-item *
copy-item [-Path] [-Destination] [-Include] [-Exclude]
move-item [-Path] [-Destination] [-Include] [-Exclude]
new-item -ItemType  # Aliases: ni, md, mkdir
rename-item
remove-item # aliases: del

get-localuser
Disable-LocalUser
Enable-LocalUser
set-localuser
New-LocalUser

get-location # aliases: gl pwd
Set-Location # aliases: sl cd chdir

# Sends output to a file.
# -NoClobber don't override
out-file [-FilePath] [-append] [-NoClobber] [-Force]
# Example 1: Send output and create a file 
Get-Process | Out-File -FilePath .\Process.txt
Get-Content -Path .\Process.txt

Get-Content
Add-Content
Set-Content

# The default format in PowerShell ist Format-Table
get-localuser admin | Format-List

Get-ExecutionPolicy [-list]
Set-ExecutionPolicy [-ExecutionPolicy] {AllSigned | Bypass | Default | RemoteSigned | Restricted | Undefined | Unrestricted} [[-Scope] {CurrentUser | LocalMachine | 
    MachinePolicy | Process | UserPolicy}] [-Force] [-Confirm] [-WhatIf] [<CommonParameters>]

#Example 4: Set the scope for an execution policy -------   
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser
Get-ExecutionPolicy -List
# Example 5: Remove the execution policy for the current user -
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
Get-ExecutionPolicy -List

# To see the class and all the members (methods and properties) of an object
Get-LocalUser | Get-Member

# where-object [-property]
Get-LocalUser | Where-Object {$PSItem.Name -eq 'admin'} | Format-List
Get-LocalUser -name admin | Format-List #equivalent

# List enabled users
Get-LocalUser | Where-Object {$PSItem.Enabled -eq $true}

# Selects objects or object properties
Sort-Object [-CaseSensitive] [-Descending] [-Unique]

# Displays the properties name and enabled of the first 2 local users
Get-LocalUser | Select-Object -First 2 -Property name, enabled 


Export-Csv [-Path] [-Delimiter] [-Append] [-Encoding {ASCII | BigEndianUnicode | Default | OEM | Unicode | UTF7 | UTF8 | UTF32}] [-Force] 
 

Get-LocalUser | Select-Object name, enabled | Export-Csv -Path .\localuser.csv -NoTypeInformation

# Remark: Always use the select-object to filter the properties before using the where-object to filger by value