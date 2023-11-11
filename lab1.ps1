<# Lab 1
1. Start the spooler service with a pipeline. If it is started already, stop the spooler service.
2. Find the Cmdlet for getting Disk information of you system.
3. Find the Cmdlet for getting Volume information of your system.
4. Use the Cmdlet in question 3 to just show the C drive
5. Create a local user with PowerShell on your system.
#>
clear-host

Write-Host "`nGetting and starting the spooler..."
Get-Service -Name Spooler | Start-Service
Get-Service -Name Spooler

Write-Host "`nDisplaying the hard disk..."
Get-Disk | format-table
get-disk | format-list

write-host "`nDisplaying the computer volume..."
Get-Volume | format-table
get-volume | format-list
Get-Volume -DriveLetter C | format-table
Get-Volume -DriveLetter C | Format-List

write-host "`nCreaing a new local user..."
get-localuser test_local_user
Remove-LocalUser test_local_user
New-LocalUser test_local_user
get-localuser test_local_user