'1. Make a script that will check the status of the service provided by the user.
If the services status equals "running" then stop the service, 
If the status equals "stopped" start the service.'

'Please provide the name of the service: '
[String]$SeviceProvided = Read-Host

$ServiceObject = Get-Service -Name $SeviceProvided
'The service named '+$ServiceObject.Name+' has the status'+$ServiceObject.Status

if($ServiceObject.Status -eq 'Running')
{
    'Stopping the service named ' + $ServiceObject.Name
    Stop-Service $ServiceObject.Name
}
elseif($ServiceObject.Status -eq 'Stopped')
{
    'Starting the service named ' + $ServiceObject.Name
    Start-Service $ServiceObject.Name
}

'2. The same as exercise 1, only now, ask the user if he wants to really start the service (in case the service is topped) 
or if he wants to stop the service (in case the service is started).
Try to do this with a nested If/Elseif statement. A way of doing this is reading a yes (Y) or no (N) answer with a Read-Host statement inside your nested if.'