

$DESKTOP = "$([Environment]::GetFolderPath('Desktop'))"
$LINK_NAME = "${DESKTOP}\Books.lnk"

del $LINK_NAME

$WshShell = New-Object -ComObject WScript.Shell

$Shortcut = $WshShell.CreateShortcut(
    $LINK_NAME
)

$Shortcut.TargetPath = "${MY_ONEDRIVE}\Books"

<#
$Shortcut.TargetPath = "C:\Program Files\PowerShell\7\pwsh.exe"
$Shortcut.WorkingDirectory = "C:\Users\$env:USERNAME"
$Shortcut.Description = "PowerShell 7"
$Shortcut.IconLocation = "C:\Program Files\PowerShell\7\pwsh.exe,0"

#>

$Shortcut.Save()