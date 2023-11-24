<#
Create a PowerShell script which will import these users locally. 
- Make sure that these users are able to login. 
- Also make sure that the department header in the CSV file will be the description property of the new localuser.
#>

$NewPersonals = Import-Csv -Path "C:\Users\admin\powershell_scripting\new_personal.csv"

foreach($NewPersonal in $NewPersonals)
{
    $SecurePassword = ConvertTo-SecureString $NewPersonals.Pa
}