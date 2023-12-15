# Uncomment the following command to see all local users on your system
# Get-LocalUser

$UserName = 'user01' # Set this to a local user existing in your system
# Get the local user object named $UserName
$UserObject = Get-LocalUser -Name $UserName
$UserObject

'Is the user ' + $UserName + ' enabled ? ' + $UserObject.Enabled

# Disable the user user01 if he is enabled
if($UserObject.Enabled -eq $True){
    Disable-LocalUser -InputObject $UserObject
    #Disable-LocalUser -Name $UserObject.Name # option 1
    $UserObject = Get-LocalUser -Name $UserObject.Name # option 2
    'If Is the user ' + $UserName + ' enabled ? ' + $UserObject.Enabled
# Or enable it if it his disabled
} else {
    Enable-LocalUser -InputObject $UserObject
    #Enable-LocalUser -Name $UserObject.Name # option 1
    $UserObject = Get-LocalUser -Name $UserObject.Name # option 2
    'Else Is the user ' + $UserName + ' enabled ? ' + $UserObject.Enabled
}