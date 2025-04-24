# Script to add a prefix to all filenames in a selected folder
# Usage: Run the script, select a folder, provide a prefix when prompted
# You can choose whether to include subfolders or just the main folder

Add-Type -AssemblyName System.Windows.Forms

function Get-FolderPath {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Select a folder containing files to rename"
    $folderBrowser.ShowNewFolderButton = $false
    
    if ($folderBrowser.ShowDialog() -eq "OK") {
        return $folderBrowser.SelectedPath
    } else {
        Write-Host "No folder selected. Exiting script."
        exit
    }
}

# Get folder path from user
$folderPath = Get-FolderPath
Write-Host "Selected folder: $folderPath"

# Get prefix from user
$prefix = Read-Host -Prompt "Enter the prefix to add to each filename"

# Validate prefix
if ([string]::IsNullOrWhiteSpace($prefix)) {
    Write-Host "Prefix cannot be empty. Exiting script."
    exit
}

# Ask user if they want to include subfolders
$includeSubfolders = Read-Host -Prompt "Include files in subfolders? (Y/N)"
$includeSubfolders = ($includeSubfolders -eq "Y" -or $includeSubfolders -eq "y")

# Get all files in the folder (and subfolders if selected)
if ($includeSubfolders) {
    $files = Get-ChildItem -Path $folderPath -File -Recurse
    Write-Host "Including files in subfolders."
} else {
    $files = Get-ChildItem -Path $folderPath -File
    Write-Host "Only including files in the main folder."
}

# Check if any files were found
if ($files.Count -eq 0) {
    Write-Host "No files found in the selected folder."
    exit
}

# Preview the changes
Write-Host "`nThe following files will be renamed:"
foreach ($file in $files) {
    $newName = "$prefix$($file.Name)"
    $relativePath = $file.FullName.Substring($folderPath.Length + 1)
    Write-Host "$relativePath --> $(Split-Path -Path $relativePath -Parent)\$newName"
}

# Confirm the operation
$confirmation = Read-Host -Prompt "`nDo you want to proceed with renaming these files? (Y/N)"
if ($confirmation -ne "Y" -and $confirmation -ne "y") {
    Write-Host "Operation cancelled."
    exit
}

# Rename the files
$renamedCount = 0
foreach ($file in $files) {
    $newName = "$prefix$($file.Name)"
    
    try {
        Rename-Item -Path $file.FullName -NewName $newName -ErrorAction Stop
        $renamedCount++
    } catch {
        Write-Host "Error renaming $($file.FullName): $_" -ForegroundColor Red
    }
}

if ($includeSubfolders) {
    Write-Host "`nRenamed $renamedCount out of $($files.Count) files successfully (including files in subfolders)."
} else {
    Write-Host "`nRenamed $renamedCount out of $($files.Count) files successfully."
}