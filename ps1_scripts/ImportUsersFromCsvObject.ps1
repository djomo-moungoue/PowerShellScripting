$UsersFromCsvObject = Import-csv -Path "C:\Users\admin\powershell_scripting\users.csv"
$LocalUsers = Get-LocalUser | Select-Object Name
$LocalUsers
foreach($User in $UsersFromCsvObject)
{
    if($User.LOGONNAME -notin $LocalUsers)
    {
        $User.LOGONNAME

        $SecureString = ConvertTo-SecureString -String $User.PASSWORDOFUSER -AsPlainText -Force
        New-LocalUser -Name $User.LOGONNAME -Password $SecureString -Description $User.DESCRIPTION
    }
}
Write-Host
Get-LocalUser