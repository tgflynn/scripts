

<#
param(
    [Parameter(Mandatory)]
    [string]$Command,
    
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Arguments
)
 
Start-Process -FilePath (Get-Command $Command).Source -ArgumentList @Arguments -Verb RunAs
#>

param(
    [string]$Command,

    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Arguments
)

$resolved = Get-Command $Command -ErrorAction SilentlyContinue

if ($resolved -and $resolved.CommandType -ne 'Application') {
    $script = "& '$Command' " + ($Arguments -join ' ')
    Start-Process pwsh.exe -Verb RunAs -ArgumentList @(
        '-NoProfile',
        '-Command',
        $script
    )
}
else {
    Start-Process -FilePath $Command `
        -ArgumentList $Arguments `
        -Verb RunAs
}