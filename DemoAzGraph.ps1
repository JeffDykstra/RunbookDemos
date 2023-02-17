#Requires -module Az.ResourceGraph
param([string]$EnvironmentTag='PRD')
Connect-AzAccount -Identity
$ResoureGroupQuery = @"
resourcecontainers
| where type == "microsoft.resources/subscriptions/resourcegroups" and tags["Environment Type"] == '$EnvironmentTag'
| join kind =inner (resources
| where type == "microsoft.compute/virtualmachines" 
| extend osType = properties.storageProfile.osDisk.osType 
| project resourceGroup,name,osType 
| summarize LinuxVMs=countif(osType=='Linux'),WindowsVMs=countif(osType=='Windows') by resourceGroup) on resourceGroup
| extend Environment = tags["Environment Type"]
| extend AppOwner = tags["Application Owner"]
| extend boolLinuxVM = tobool(case(LinuxVMs >0, "True","False"))
| extend boolWindowsVM = tobool(case(WindowsVMs >0, "True","False"))
| join kind = leftouter ( resources | where type== 'microsoft.insights/metricalerts' or type== 'microsoft.insights/activitylogalerts' or type== 'microsoft.insights/scheduledqueryrules'| summarize DefaultRuleCount = count(),rulelist=make_list(name) by resourceGroup) on resourceGroup 
| project name,resourceGroup,location,subscriptionId,LinuxVMs,WindowsVMs,Environment,AppOwner,boolLinuxVM,boolWindowsVM,id,DefaultRuleCount,rulelist 
| sort by subscriptionId
"@
$uri = Get-AutomationVariable -name SendEmailUri
$RgswithVMinfo = Search-AzGraph -Query $ResoureGroupQuery -UseTenantScope
$RgswithVMinfo | foreach-object {
    Invoke-RestMethod -ContentType "application/json" -body ($_ | ConvertTo-Json) -Method Post -Uri $uri

}