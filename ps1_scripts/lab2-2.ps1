'1. Make a script that will check the status of the service provided by the user.
If the services status equals "running" then stop the service, 
If the status equals "stopped" start the service.'

'Please provide the name of the service: '
[String]$SeviceProvided = Read-Host

$ServiceObject = Get-Service -Name $SeviceProvided
'The service named '+$ServiceObject.Name+' is '+$ServiceObject.Status

if($ServiceObject.Status -eq 'running')
{
    'Stopping the service ' + $ServiceObject.Name + ' ...'
    Stop-Service $ServiceObject.Name
}
elseif($ServiceObject.Status -eq 'stopped')
{
    'Starting the service named ' + $ServiceObject.Name + ' ...'
    Start-Service $ServiceObject.Name
}

$ServiceObject = Get-Service -Name $SeviceProvided
'The service named '+$ServiceObject.Name+' is '+$ServiceObject.Status
write-host
'2. The same as exercise 1, only now, ask the user if he wants to really start the service (in case the service is topped) 
or if he wants to stop the service (in case the service is started).
Try to do this with a nested If/Elseif statement. A way of doing this is reading a yes (Y) or no (N) answer with a Read-Host statement inside your nested if.'

'Please provide the name of the service: '
[String]$SeviceProvided = Read-Host

$ServiceObject = Get-Service -Name $SeviceProvided
'The service named '+$ServiceObject.Name+' is '+$ServiceObject.Status

if($ServiceObject.Status -eq 'Running')
{
    'Should I stop the service '+ $ServiceObject.Name + ' ? (Y/N): '
    $Answer = Read-Host
    if($Answer -eq 'Y')
    {
       '('+ $Answer + ') OK Stopping the service ' + $ServiceObject.Name + ' ...'
        Stop-Service $ServiceObject.Name
    }
    elseif($Answer -eq 'N')
    {
       '('+ $Answer + ') OK Status of the service ' + $ServiceObject.Name + ' not modified.'
    }
}
elseif($ServiceObject.Status -eq 'Stopped')
{
    'Should I start the service '+ $ServiceObject.Name + ' ? (Y/N): '
    $Answer = Read-Host
        if($Answer -eq 'Y')
    {
        '('+ $Answer + ') OK Starting the service named ' + $ServiceObject.Name + ' ...'
        Start-Service $ServiceObject.Name
    }
    elseif($Answer -eq 'N')
    {
       '('+ $Answer + ') OK Status of the service ' + $ServiceObject.Name + ' not modified.'
    }
}

$ServiceObject = Get-Service -Name $SeviceProvided
'The service named '+$ServiceObject.Name+' is '+$ServiceObject.Status