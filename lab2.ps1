write-host "`n1. Show all services that are running on you screen."
get-service | where-object {$PSItem.status -eq 'running'}

write-host "`n2. Display the spooler service on your screen with the Where-Object cmdlet."
get-service | where-object {$psitem.name -eq 'spooler'}

write-host "`n3. Show the properties and methods of the Get-Service Cmdlet."
Get-Service | Get-Member

write-host "`n4. Create 2 new local users named Bobby and Sandra with PowerShell in your computer. If your name to be Bobby or Sandra please pick another name."
New-LocalUser -Name Bobby -Disabled -NoPassword
New-LocalUser -Name Sandra -Disabled -NoPassword
Get-LocalUser | Where-Object {$PSItem.name -eq 'Bobby' -or $PSItem.name -eq 'Sandra'} | Format-List

write-host "`n5. Now your boss wants to show all enabled accounts on your machine. Think of which cmdlets you need."
Get-LocalUser | Where-Object {$PSItem.enabled -eq $true}

write-host "`n6. Now your boss wants you to do the same as in assigment 5, but he wants those enabled accounts outputted to a .txt file."
Get-LocalUser | Where-Object {$PSItem.enabled -eq $true} | Out-File -FilePath .\enabled_user.txt -Force

write-host "`n7. Same as 5 again, but now to a basic CSV file."
Get-LocalUser | Where-Object {$PSItem.enabled -eq $true} | Export-Csv -Path .\enabled_user.csv -Force -Delimiter ',' -NoTypeInformation

write-host "`n8. The same as 7 but he only needs the name, enabled and description properties"
Get-LocalUser | Select-Object -Property name, enabled, description | Where-Object {$PSItem.enabled -eq $true} | Export-Csv -Path .\enabled_user.csv -Force -Delimiter ','  -NoTypeInformation