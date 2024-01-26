#-----------------USER PROFILE ENVIRONMENT VARIABLE PATH---------------------

# Backup the current user and system environment variable PATH
$BackupUserEnvVarPath = "$env:USERPROFILE\BackupUserEnvVarPath.csv"
if(!(Test-Path $BackupUserEnvVarPath))
{
    New-Item $BackupUserEnvVarPath
}
$UserEnvPath =  [Environment]::GetEnvironmentVariable('Path', 'User')
Set-Content -Path $BackupUserEnvVarPath -Value $UserEnvPath
#Get-Content $BackupUserEnvVarPath 

# Append the new path the user environment variable
$UserEnvPath = $UserEnvPath+";"+"C:\Program Files\Wireshark"
[Environment]::SetEnvironmentVariable('Path', $UserEnvPath, 'User')

# Verify
[Environment]::GetEnvironmentVariable('Path', 'User')

#-----------------SYSTEM ENVIRONMENT VARIABLE PATH---------------------

$BackupSystemEnvVarPath = "$env:USERPROFILE\BackupSystemEnvVarPath.csv"
if(!(Test-Path $BackupSystemEnvVarPath))
{
    New-Item $BackupSystemEnvVarPath
}

Set-Content -Path $BackupSystemEnvVarPath -Value ([Environment]::GetEnvironmentVariable('Path', 'Machine'))
#Get-Content $BackupSystemEnvVarPath
[Environment]::GetEnvironmentVariable('Path', 'Machine')
