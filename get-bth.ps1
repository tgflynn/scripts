
<#
Get-PnpDevice -Class Bluetooth |
    Format-Table Status, FriendlyName, InstanceId -AutoSize
 #>
   
Get-PnpDevice -Class Bluetooth |
    Where-Object FriendlyName -Like '*BTH*' |
    Select-Object FriendlyName, InstanceId