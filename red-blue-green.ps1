# 1. Create a Powershell script which creates a new folder.

New-Item "new folder" -Type Directory

# 2. Inside the folder creates 3 subfolders (red, green and blue).

New-Item "new folder\red" -Type Directory
New-Item "new folder\green" -Type Directory
New-Item "new folder\blue" -Type Directory

# 3. In the parent folder the script must create 50 files called redFile01.txt to redFile50.txt, 50 files called blueFile01.txt to blueFile50.txt and 50 files called greenFile01.txt to greenFile50.txt.

# Create the Red files

for ($i = 1; $i -le 50; $i++) {

    $filename = "redFile{0:D2}.txt" -f $i
    
    New-Item -Path "new folder\$filename" -Type File
    
    }

# Create the Blue files

for ($i = 1; $i -le 50; $i++) {

    $filename = "blueFile{0:D2}.txt" -f $i
    
    New-Item -Path "new folder\$filename" -Type File
    
    }

# Create the Green files

for ($i = 1; $i -le 50; $i++) {

    $filename = "greenFile{0:D2}.txt" -f $i
    
    New-Item -Path "new folder\$filename" -Type File
    
    }

# 4. The script must move all the files to a proper directories the blue files to the blue folder, the red files to the red folder and the green files to the green folder.

Get-ChildItem -Path ".\new folder" -Filter "blueFile*.txt" | Move-Item -Destination "new folder\blue"
Get-ChildItem -Path ".\new folder" -Filter "redFile*.txt" | Move-Item -Destination "new folder\red"
Get-ChildItem -Path ".\new folder" -Filter "greenFile*.txt" | Move-Item -Destination "new folder\green"

# 5. When all the files are placed in the correct folders, the script must delete all the odd redFileXX.txt from the red folder.

Get-ChildItem -Path ".\new folder\red" -Filter "redFile*.txt" | Where-Object { $_.Name -match "(\d+).txt" -and [int]$Matches[1] % 2 -eq 1 } | Remove-Item -Force

# 6. The script must rename the blue folder to grey and rename all the blueFile.txt inside to greyFile.txt (greyFile01.txt, greyFile02.txt and etc.).

Rename-Item ".\new folder\blue" "grey"
Get-ChildItem -Path ".\new folder\grey" -Filter "blueFile*.txt" | Rename-Item -NewName{ $_.Name -replace "blue", "grey" }

# 7. The script must delete all the files from the green directory and leave the directory empty.

Remove-Item -Path ".\new folder\green\*" -Force