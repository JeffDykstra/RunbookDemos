connect-azaccount -identity
Get-AzContainerGroup | where name -like dykstramcgroup* | Stop-AzContainerGroup -Verbose