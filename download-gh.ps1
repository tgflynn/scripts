
<#
# Fetch the latest Windows x64 MSI download URL via GitHub API
$release = Invoke-RestMethod "https://github.com"
$msiUrl = ($release.assets | Where-Object { $_.name -like "*_windows_amd64.msi" }).browser_download_url
$msiPath = Join-Path $env:TEMP "gh_latest.msi"
#>

# Fetch the latest Windows x64 MSI download URL via GitHub API
$headers = @{ "User-Agent" = "PowerShell" }
$release = Invoke-RestMethod -Uri "https://github.com" -Headers $headers
$msiUrl = ($release.assets | Where-Object { $_.name -like "*_windows_amd64.msi" }).browser_download_url

Write-Host "release = ", $release
Write-Host "msiUrl = ", $($msiUrl)


if (-not $msiUrl) {
    Write-Error "Could not find the Windows amd64 MSI URL in the latest release."
    exit 1
}

Write-Host $msiPath

<#
# Download and install silently for all users
Invoke-WebRequest -Uri $msiUrl -OutFile $msiPath
Start-Process msiexec.exe -ArgumentList "/i `"$msiPath`" ALLUSERS=1 /qn /norestart" -Wait
Remove-Item $msiPath
#>
