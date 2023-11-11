write-host "`nCreating a user account that has a password..."
$Password = Read-Host -AsSecureString
$params = @{
    Name        = 'user01'
    Password    = $Password
    FullName    = 'Third User'
    Description = 'Description of this account.'
}
New-LocalUser @params
Get-LocalUser -name user01 | format-list