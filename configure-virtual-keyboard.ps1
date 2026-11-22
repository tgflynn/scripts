# Run as Administrator

# 1. Disable On-Screen Keyboard for the current user after sign-in
$userATPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Accessibility"
if (Test-Path $userATPath) {
    $currentConfig = (Get-ItemProperty -Path $userATPath -Name "Configuration" -ErrorAction SilentlyContinue).Configuration
    Write-Host $currentConfig
    if ($currentConfig) {
        # Remove 'osk' from the comma-separated list of active assistive technologies
        $newConfig = ($currentConfig -split ',' | Where-Object { $_ -ne 'osk' -and $_ -ne '' }) -join ','
        Set-ItemProperty -Path $userATPath -Name "Configuration" -Value $newConfig
        Write-Host "Updated current user Accessibility Configuration to: '$newConfig'" -ForegroundColor Green
    } 
}


# 2. Disable On-Screen Keyboard on the Windows Sign-In / Lock Screen
$machineATPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Accessibility"
if (Test-Path $machineATPath) {
    $machineConfig = (Get-ItemProperty -Path $machineATPath -Name "Configuration" -ErrorAction SilentlyContinue).Configuration
    if ($machineConfig) {
        $newMachineConfig = ($machineConfig -split ',' | Where-Object { $_ -ne 'osk' -and $_ -ne '' }) -join ','
        Set-ItemProperty -Path $machineATPath -Name "Configuration" -Value $newMachineConfig
        Write-Host "Updated Sign-In Screen Accessibility Configuration to: '$newMachineConfig'" -ForegroundColor Green
    }
}

# 3. Check standard Startup folders just in case a manual shortcut was added
$startupPaths = @(
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
)

foreach ($path in $startupPaths) {
    $oskShortcuts = Get-ChildItem -Path $path -Filter "*osk*" -ErrorAction SilentlyContinue
    if ($oskShortcuts) {
        Write-Warning "Found manual shortcut in $path : $($oskShortcuts.Name). You may want to delete it."
    }
}

