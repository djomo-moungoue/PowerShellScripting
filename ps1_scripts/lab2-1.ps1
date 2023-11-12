'1. Display PowerShell 3 times on your screen'
$Name = 'PowerShell'
$Name
$Name
$name

'2. Let PowrShell ask for your name in a prompt and display a welcome <your name>'
'What is your name please?'
$Name = Read-Host
'Welcome ' +$Name 

'3. Let the script ask for the name of a service you want to display and show that service on the screen. So if someone types spooler then the spooler service should be shown on the screen.'
'What service do you want to display?'
$ServiceName = Read-Host
Get-Service -Name $ServiceName

