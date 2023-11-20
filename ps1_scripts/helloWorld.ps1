# Declare the an empty rray
$EmptyArray = @()
'EmptyArray: '+$EmptyArray

# Declare an non empty Array
$NonEmptyArray = @('Zero')
'NonEmptyArray: '+$NonEmptyArray

$EmptyArray = $EmptyArray + 'First'
$EmptyArray += 'Second'
$EmptyArray += 'Third'
$EmptyArray += 'Fourth'
'EmptyArray after assignment: '+$EmptyArray

[Int]$Count = 0

$NonEmptyArray += 'Third'
'NonEmptyArray after assignment: '+$NonEmptyArray

foreach($Item in $EmptyArray)
{
    "$Count"+". "+$Item
    $Item+". "+$Count
    $count +=1
}

$LocalUsers = Get-LocalUser
$LocalUsers.getType()
"First user: "
$LocalUsers[0] | Format-Table
"First user name: "+ $LocalUsers[0].Name
"First user enabled? "+ $LocalUsers[0].Enabled
"Last user: "
$LocalUsers[-1] | Format-Table
"Last user name: "+ $LocalUsers[-1].Name
"Last user enabled? "+ $LocalUsers[-1].Enabled