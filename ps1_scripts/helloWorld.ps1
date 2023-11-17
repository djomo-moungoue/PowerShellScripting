$RandNum = Get-Random -Minimum 1 -Maximum 5
"Please guess the number: "
[Int]$UserInput = Read-Host

while($RandNum -ne $UserInput)
{
    "Sorry that guess is not correct, please guess again !"
    "Please guess the number: "
    [Int]$UserInput = Read-Host
}

"YESSS, you guessed it, the number is "+$RandNum