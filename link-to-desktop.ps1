$WshShell = New-Object -ComObject WScript.Shell

$Shortcut = $WshShell.CreateShortcut(
    "$([Environment]::GetFolderPath('Desktop'))\MyShortcut.lnk"
)

$Shortcut.TargetPath = "C:\Program Files\PowerShell\7\pwsh.exe"
$Shortcut.WorkingDirectory = "C:\Users\$env:USERNAME"
$Shortcut.Description = "PowerShell 7"
$Shortcut.IconLocation = "C:\Program Files\PowerShell\7\pwsh.exe,0"

$Shortcut.Save()