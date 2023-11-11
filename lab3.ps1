write-host "`n1. Now your boss wants you to show all enabled accounts on your machine and change the description property in 'Enabled account'"
Get-LocalUser | where {$PSItem.enabled -eq $True} | Set-LocalUser -description 'Enabled account'
Get-LocalUser | where {$PSItem.enabled -eq $True} 

write-host "`n2.Everybody with the description property with the value of 'Enabled Account' should be shown on the screen."
Get-LocalUser | where {$PSItem.description -eq 'Enabled Account'} 

write-host "`n3.Same as 2 but now to a .txt file."
Get-LocalUser | where {$PSItem.description -eq 'Enabled Account'} | Out-File -FilePath .\enabled_accounts.txt