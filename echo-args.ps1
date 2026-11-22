
#param(
#    [Parameter(Mandatory)]
#    [string]$Command
#)
 
#echo $Command
echo $($args[0])
echo $args
Write-Host "Hello, $($args[0])!"