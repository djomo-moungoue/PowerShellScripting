# Get the local user object named user01
$User = Get-LocalUser -Name 'user01'
$User

# Save his current status
$IsEnabled = $User | Select-Object Enabled

'Is the user ' + $User + ' enabled ? ' + $IsEnabled.Enabled

# Disable the user user01 if he is enabled
if($IsEnabled.Enabled -eq $True){
    $User | Disable-LocalUser
    $User = Get-LocalUser -Name 'user01'
    $IsEnabled = $User | Select-Object Enabled
    'If Is the user ' + $User + ' enabled ? ' + $IsEnabled.Enabled
# Or enable it if it his disabled
} else {
    $User | Enable-LocalUser
    $User = Get-LocalUser -Name 'user01'
    $IsEnabled = $User | Select-Object Enabled
    'Else Is the user ' + $User + ' enabled ? ' + $IsEnabled.Enabled
}