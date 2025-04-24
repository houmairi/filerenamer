# File Prefix Renamer

A simple PowerShell script that lets you add a prefix to all filenames in a selected folder.

## Features

- Select a folder using a graphical interface
- Add a custom prefix to all filenames while preserving extensions
- Preview changes before applying
- Confirmation prompt to prevent accidental renaming

## Usage

1. Save the script as `AddPrefixToFiles.ps1`
2. Run the script by right-clicking and selecting "Run with PowerShell" or by opening PowerShell and running `.\AddPrefixToFiles.ps1`
3. Select the target folder when prompted
4. Enter your desired prefix
5. Review the preview of changes
6. Confirm to apply the changes

## Requirements

- Windows operating system
- PowerShell 3.0 or later

## Execution Policy

If you encounter restrictions running the script, you may need to adjust your PowerShell execution policy:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

## Example

Original files:
- document.docx
- image.jpg
- notes.txt

After running with prefix "Project_":
- Project_document.docx
- Project_image.jpg
- Project_notes.txt