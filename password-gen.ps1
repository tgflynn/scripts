$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+'
$length = 16
$password = -join (1..$length | ForEach-Object { $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)] })
$password | Set-Clipboard
Write-Output "Copied to clipboard: $password"
