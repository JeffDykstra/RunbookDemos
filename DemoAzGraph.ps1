Connect-AzAccount -Identity
$query = @'
resourcecontainers
| where type == "microsoft.resources/subscriptions/resourcegroups"
| join kind =inner (resources
| where type == "microsoft.compute/virtualmachines" 
| extend osType = properties.storageProfile.osDisk.osType 
| project resourceGroup,name,osType 
| summarize LinuxVMs=countif(osType=='Linux'),WindowsVMs=countif(osType=='Windows') by resourceGroup) on resourceGroup
| extend Environment = tags.Environment
| extend AppOwner = tags["Application Owner"]
| extend boolLinuxVM = tobool(case(LinuxVMs >0, "True","False"))
| extend boolWindowsVM = tobool(case(WindowsVMs >0, "True","False"))
| project name,resourceGroup,subscriptionId,Environment,AppOwner,id,boolLinuxVM,boolWindowsVM
'@
$RgswithVMinfo = Search-AzGraph -Query $query -UseTenantScope
$RgswithVMinfo