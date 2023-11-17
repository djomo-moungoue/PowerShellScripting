# Declare the an empty rray
$EmptyArray = @()
'EmptyArray: '+$EmptyArray

# Declare an non empty Array
$NonEmptyArray = @('Zero')
'NonEmptyArray: '+$NonEmptyArray

$EmptyArray = $EmptyArray + 'First'
$EmptyArray += 'Second'
'EmptyArray after assignment: '+$EmptyArray

$NonEmptyArray += 'Third'
'NonEmptyArray after assignment: '+$NonEmptyArray