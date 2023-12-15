$UserList = "C:\Users\admin\powershell_scripting\new_users.txt"
$UsersToCreate = Get-Content -Path $UserList
$LocalUsers = Get-LocalUser

foreach($User in $UsersToCreate)
{
    # This command converts the plain text string $User into a secure string and stores the result in the $Password variable.
    # Starting in PowerShell 7, the Force parameter is not required when using the AsPlainText parameter. However, including the Force parameter ensures the statement is compatible with earlier versions
    $Password = ConvertTo-SecureString -String $User -AsPlainText -Force
    if($User -notin $LocalUsers)
    {
        New-LocalUser -Name $User -FullName (Get-Culture).TextInfo.ToTitleCase($User) -Password $Password
        Write-Host "Pwd $User : $Password"
    }
}