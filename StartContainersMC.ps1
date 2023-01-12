Connect-AzAccount -Identity
Get-AzContainerGroup | where name -like dykstramcgroup* | Start-AzContainerGroup -Verbose