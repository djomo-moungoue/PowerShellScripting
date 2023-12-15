#1. Put all the services in a $-services array. Now for all the services display The <nameofservices> is a great service !
$Services = Get-Service

Write-Host
foreach($Service in $Services)
{
    "The "+ $Service.Name +" is a great service !"
}

<#
2. Put all the services in the $Services array. Again, display 'The <nameofservice> is a great service !' But if your system found the spooler service it additionaly
needs to display 'Wow, I found the spooler service ! Really Cool!'
#>

Write-Host
foreach($Service in $Services)
{
    "The "+ $Service.Name +" is a great service !"
    if($Service.Name -eq "Spooler"){
        "Wow, I found the spooler service ! Really Cool!"
    }
}

<#
3. Look at the output of exercise 2, now try the same, but the Spooler is found, is should only display 'Wow, found the spooler service ! Really Cool !' and
 also 'The spooler is a great service'
#>
Write-Host
foreach($Service in $Services)
{
    if($Service.Name -eq "Spooler"){
        "Wow, I found the spooler service ! Really Cool!"
    }
    else
    {
        "The "+ $Service.Name +" is a great service !"
    }
}




