$CurrentComputer = $env:COMPUTERNAME
Get-Date -Format "dd/MM/yyyy hh:mm:ss"
Write-Host
"==========================$CurrentComputer======================"
Write-Host
if($CurrentComputer -eq "DESKTOP-18EEUA3")
{# Make sure the script is ran on the correct computer
    $UsersFromCsvObject = Import-csv -Path "C:\Users\admin\powershell_scripting\users.csv"
    $UsersFromCsvObject | Format-Table

    foreach($User in $UsersFromCsvObject)
    {
        # Count the occurences of local users named $User.LOGONNAME
        $Count = Get-LocalUser -Name $User.LOGONNAME | Measure-Object
        if($Count.Count -eq 0)
        {

            $SecurePassword = ConvertTo-SecureString -String $User.PASSWORDOFUSER -AsPlainText -Force
            New-LocalUser -Name $User.LOGONNAME -Password $SecurePassword -Description $User.DESCRIPTION
        }
    }
}
Write-Host
"==========================$CurrentComputer======================"
Write-Host
Get-Date -Format "dd/MM/yyyy hh:mm:ss"
