# See all local users on your system
Get-LocalUser

$UserName = 'user01' # Set this to a local user existing in your system
# Get the local user object named $UserName
$UserObject = Get-LocalUser -Name $UserName
$UserObject

# Save his current status
$IsEnabled = $UserObject | Select-Object Enabled

'Is the user ' + $User + ' enabled ? ' + $IsEnabled.Enabled

# Disable the user user01 if he is enabled
if($IsEnabled.Enabled -eq $True){
    $UserObject | Disable-LocalUser
    $UserObject = Get-LocalUser -Name $UserName
    $IsEnabled = $UserObject | Select-Object Enabled
    'If Is the user ' + $UserName + ' enabled ? ' + $IsEnabled.Enabled
# Or enable it if it his disabled
} else {
    $UserObject | Enable-LocalUser
    $UserObject = Get-LocalUser -Name $UserName
    $IsEnabled = $UserObject | Select-Object Enabled
    'Else Is the user ' + $UserName + ' enabled ? ' + $IsEnabled.Enabled
}