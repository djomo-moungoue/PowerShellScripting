write-host "`n1. You are asked to create a directory with PowerShell named 'mydir'"
new-item -Path mydir -ItemType Directory

write-host "`n2. Now you have to create tow text files in there with PowerShell named 1.txt and 2.txt. These can be empty."
new-item -Path .\mydir\1.txt, .\mydir\2.txt -ItemType File
get-item .\mydir\*

write-host "`n3. Now you have to create two .jpg files in there with PowerShell named 1.jpg and 2.jpg. Doesn't have to be an actual picture."
new-item -Path .\mydir\1.jpg, .\mydir\2.jpg -ItemType File
get-item .\mydir\*

write-host "`n4. Remove all the files 1.txt, 2.txt, 1.jpg, 2.jpg in a one liner using the pipeline."
Get-ChildItem -Path .\mydir | Remove-Item
Get-ChildItem -Path .\mydir

write-host "`n4. Remove only the txt files in a one liner using the pipeline."
Get-ChildItem -Path .\mydir | Where-Object {$PSItem.name -like '*.txt'} | Remove-Item 
Get-ChildItem -Path .\mydir

# Alternative method
Get-ChildItem -path .\mydir | Get-Member
Get-ChildItem -Path .\mydir | Where-Object {$PSItem.extension -eq '.jpg'} | Remove-Item 

write-host "`n9. Retrieve all the processes on your screen with a handle count less than 100."
Get-Process | Where-Object {$PSItem.HandleCount -lt 100}
Get-Process | Where-Object {$PSItem.Handles -lt 100}