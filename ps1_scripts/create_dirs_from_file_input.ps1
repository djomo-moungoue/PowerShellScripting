$Sources = "C:\Users\admin\powershell_scripting\sources"
if(!(Test-Path $Sources))
{
    $Sources = New-Item -Path "C:\Users\admin\powershell_scripting\sources" -ItemType directory
}
$Dirs = "$Sources\dirs.txt"
if(!(Test-Path $Dirs))
{
    $Dirs = New-Item -Path "$Sources\dirs.txt" -ItemType file
}
Set-Content -Path $Dirs -Value "user01"
Add-Content -Path $Dirs -Value "user02"
Add-Content -Path $Dirs -Value "user03"
Add-Content -Path $Dirs -Value "user04"
Add-Content -Path $Dirs -Value "user05"
$Files = Get-Content -Path $Dirs

foreach($File in $Files)
{
    if(!(Test-Path "$Sources\$File"))
    {
        New-Item -path $Sources -Name $File -ItemType "directory"
    }
}
Get-ChildItem $Sources