
param(
    [string]$User,
    [string]$Command,

    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Arguments
)



$ResolvedCommand = Get-Command $Command -ErrorAction SilentlyContinue

# Write-Output "ResolvedCommand = " $ResolvedCommand
Write-Output "ResolvedCommand.Source = $($ResolvedCommand.Source)"
Write-Output "ResolvedCommand.Path = $($ResolvedCommand.Path)"

Write-Output "User = $User"

<#
$cred = Get-Credential -UserName $User
Start-Process -FilePath $ResolvedCommand -ArgumentList $Arguments -Credential $cred -LoadUserProfile -Wait
#>
