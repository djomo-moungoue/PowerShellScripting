<#
This script backups files from 
.\backlog\
- file1.txt
- file2.csv
- file3.jpg
- file8.mp3
- file4.jpg
- file5.doc
- file6.bmp
- file7.mp3

to 
.\_backup\
- texts
    - file1.txt
    - file2.csv
    - file5.md
- images
    - file3.jpg
    - file4.jpg
    - file6.bmp
- audios
    - file8.mp3
    - file7.mp3
#>

Clear-Host

"Source folder ..."
$Backlog = ".\backlog"

if(!(Test-Path $Backlog))
{
	"Create the source folder and add files into it ..."
    New-Item -ItemType Directory 
    New-Item -ItemType File "${Backlog}\file1.txt"
    New-Item -ItemType File "${Backlog}\file2.csv"
    New-Item -ItemType File "${Backlog}\file3.jpg"
    New-Item -ItemType File "${Backlog}\file8.mp3"
    New-Item -ItemType File "${Backlog}\file4.jpg"
    New-Item -ItemType File "${Backlog}\file5.md"
    New-Item -ItemType File "${Backlog}\file6.bmp"
    New-Item -ItemType File "${Backlog}\file7.mp3"
}

"Retrieve files from the source folder ..."
Get-ChildItem -Path $Backlog -Recurse

$Destination = ".\_backup"
$Texts = ".\_backup\texts"
$Images = ".\_backup\images"
$Audios = ".\_backup\audios"
if(!(Test-Path $Destination))
{
    "The destionation folder doesn't exist ..."
    New-Item -ItemType Directory $Destination
    New-Item -ItemType Directory $Texts
    New-Item -ItemType Directory $Images
    New-Item -ItemType Directory $Audios
}
else
{
    "The destination folder exist. Check if the subfolders exists ..."
    if(!(Test-Path $Texts))
    {
        New-Item -ItemType Directory $Texts
    }
    if(!(Test-Path $Images))
    {
        New-Item -ItemType Directory $Images
    }
    if(!(Test-Path $Audios))
    {
        New-Item -ItemType Directory $Audios
    }
}

"Move the files in the appropriate destionation subfolder ..."
$files = Get-ChildItem $Backlog | Select-Object FullName, Name, Extension
foreach($file in $files)
{
    if($file.Extension -in @(".txt", ".csv", ".md"))
    {
        Copy-Item -Path $file.FullName -Destination $Texts
    }
    elseif($file.Extension -in @(".jpg", ".bmp"))
    {
        Copy-Item -Path $file.FullName -Destination $Images
    }
    elseif($file.Extension -in @(".mp3"))
    {
        Copy-Item -Path $file.FullName -Destination $Audios
    }
}

"Retrieve the content of all folders and subfolders"
"To check visually if the script did the job./."
Get-ChildItem -Path $Destination -Recurse