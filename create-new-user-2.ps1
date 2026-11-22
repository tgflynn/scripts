# 1. Automatically elevate the script if not running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Restarting script with Administrator privileges..." -ForegroundColor Yellow
    # Detect whether running in pwsh.exe (PS 7+) or powershell.exe (PS 5.1)
    $pwshPath = (Get-Process -Id $PID).Path
    Start-Process -FilePath $pwshPath -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Stop execution immediately if any command throws a terminating error
$ErrorActionPreference = "Stop"

$username = "merlin"

try {
    # 2. Check if the user already exists before attempting creation
    if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
        Write-Warning "The local user '$username' already exists. No changes were made."
        exit
    }

    # Prompt for the account password
    $password = Read-Host "Enter password for $username" -AsSecureString

    # Create the local user
    New-LocalUser `
        -Name $username `
        -FullName "Merlin" `
        -Description "Local software development account" `
        -Password $password `
        -PasswordNeverExpires

    # 3. Add the account to the Administrators group
    Add-LocalGroupMember -Group "Administrators" -Member $username

    Write-Host "Success: Local administrator '$username' has been created." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create user '$username': $($_.Exception.Message)"
}
