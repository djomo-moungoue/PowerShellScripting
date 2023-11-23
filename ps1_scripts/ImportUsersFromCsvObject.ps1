$UsersFromCsvObject = Import-csv -Path "C:\Users\admin\powershell_scripting\users.csv"
$UsersFromCsvObject.GetType()
$UsersFromCsvObject | Format-Table

foreach($User in $UsersFromCsvObject)
{
    # Count the occurences of local users named $User.LOGONNAME
    $Count = Get-LocalUser -Name $User.LOGONNAME | Measure-Object
    $User.LOGONNAME 
    $Count.Count
    if($Count.Count -eq 0)
    {

        $SecurePassword = ConvertTo-SecureString -String $User.PASSWORDOFUSER -AsPlainText -Force
        New-LocalUser -Name $User.LOGONNAME -Password $SecurePassword -Description $User.DESCRIPTION
    }
}
