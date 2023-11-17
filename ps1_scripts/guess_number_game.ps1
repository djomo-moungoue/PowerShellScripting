<#
In this assignment you have to take a random number between 1 and 10 via the Get-Random cmdlet.
Then ask the user to guess a number. The user now gets unlimited chances until the number is guessed.

If the user guessed correctly, congratulate him.

In the case the user has guessed too low, you need to tell the user that within your while loop.

In the case the user has guessed too high, tell him too that within your while loop.
#>
$RandNum = Get-Random -Minimum 1 -Maximum 11
"Please guess the number: "
[Int]$UserInput = Read-Host

while($RandNum -ne $UserInput)
{
    if($RandNum -gt $UserInput)
    {
        "Guess again, your number "+$UserInput+" is too low"
    }
    elseif($RandNum -lt $UserInput)
    {
        "Guess again, your number "+$UserInput+" is too high"
    }

    $UserInput = Read-Host
}
Write-Host
"YESSS, you guessed it, the number is "+$RandNum