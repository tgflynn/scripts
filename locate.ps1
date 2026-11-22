
param(
    [Parameter(Mandatory = $true)]
    [string] $Directory,

    [Parameter(Mandatory = $true)]
    [string] $Pattern,

    [switch] $CaseSensitive
)

# Verify that the directory exists.
if (-not (Test-Path -LiteralPath $Directory -PathType Container)) {
    Write-Error "Directory not found: $Directory"
    return
}

# Configure matching options.
$regexOptions = [System.Text.RegularExpressions.RegexOptions]::None

if (-not $CaseSensitive) {
    $regexOptions = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
}

# Search recursively.
Get-ChildItem -LiteralPath $Directory -File -Recurse -ErrorAction SilentlyContinue |
    Where-Object {
        [regex]::IsMatch($_.Name, $Pattern, $regexOptions)
    } |
    Select-Object FullName, Length, LastWriteTime
