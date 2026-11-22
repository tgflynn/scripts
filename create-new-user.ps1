# Prompt for the account password
$password = Read-Host "Enter password for merlin" -AsSecureString

# Create the local user
New-LocalUser `
    -Name "merlin" `
    -FullName "Merlin" `
    -Description "Local software development account" `
    -Password $password

# Add the account to the standard Users group
Add-LocalGroupMember -Group "Admin" -Member "merlin"