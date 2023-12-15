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