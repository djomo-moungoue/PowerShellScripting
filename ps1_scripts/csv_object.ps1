$UsersFromCsvObject = Import-csv -Path "C:\Users\admin\powershell_scripting\users.csv"
$LocalUsers = Get-LocalUser
foreach($User in $UsersFromCsvObject)
{
    if($LocalUsers -notcontains $User)
    {
        New-LocalUser -Name $User.LOGONNAME -Password $User.PASSWORDOFUSER -Description $User.DESCRIPTION
    }
}
Wirte-Host
Get-LocalUser