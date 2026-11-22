
param(
    [string]$User,
    [string]$Command,

    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Arguments
)



$ResolvedCommand = Get-Command $Command -ErrorAction SilentlyContinue

Write-Host "ResolvedCommand = " $ResolvedCommand
Write-Host "ResolvedCommand.Source = " $ResolvedCommand.Source
Write-Host "ResolvedCommand.Path = " $ResolvedCommand.Path

Write-Host "User = " $User

<#
$cred = Get-Credential -UserName $User
Start-Process -FilePath $ResolvedCommand -ArgumentList $Arguments -Credential $cred -LoadUserProfile -Wait
#>
