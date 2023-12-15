"1. Date checker. Use the appropriate cmdlet to get the date in PowerShell."
$DotNetFormat = Get-Date -Format "dddd MM/dd/yyyy HH:mm K"
"Current Date in .Net Format: " + $DotNetFormat
$UFormat = Get-Date -UFormat "%A %m/%d/%Y %R %Z"
"Current Date in UFormat: " + $UFormat
$DayOfWeek1 = Get-Date -Format "dddd" # German
"Current Day of Week (System Language DE): "+$DayOfWeek1
$CurrentDate = Get-Date # German
$DayOfWeek = $CurrentDate.DayOfWeek # English
"Current Day of Week: "+$DayOfWeek


while($DayOfWeek -ne "Friday")
{
    if($DayOfWeek -eq "Thursday")
    {
        "It is "+$DayOfWeek+" not Friday"
    }
    sleep -Seconds 1
    [String]$NewDayOfWeek = Read-Host
    if($NewDayOfWeek -eq "Friday"){
        $DayOfWeek = $NewDayOfWeek
        "It is "+$DayOfWeek
    }
}
