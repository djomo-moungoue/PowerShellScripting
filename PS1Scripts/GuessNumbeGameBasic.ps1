<#
In this assignment you have to take a random number between 1 and 5 via the Get-Random cmdlet.
Then ask the user to guess a number. The user now gets unlimited chances until the number is guessed.

If the user guessed correctly, congratulate him.

In the case the user has guessed wrong tell him to try again.
#>
$RandNum = Get-Random -Minimum 1 -Maximum 6
"Please guess the number: "
[Int]$UserInput = Read-Host

while($RandNum -ne $UserInput)
{
    "Sorry that guess is not correct, please guess again !"
    "Please guess the number: "
    $UserInput = Read-Host
}
Write-Host
"YESSS, you guessed it, the number is "+$RandNum