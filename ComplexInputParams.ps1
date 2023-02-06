#https://blogs.technet.microsoft.com/orchestrator/2014/01/10/sma-capabilities-in-depth-runbook-input-output-and-nested-runbooks/
$params = @{
workspaceID = 'f5ec9968-97eb-402d-b32a-7f90a36293ed'
ComputerName = 'dc2','dc4','vmhost5','vmhost6','vmhost7'
}
Start-AzAutomationRunbook -AutomationAccountName automation4 -ResourceGroupName OpsRG1 -Name Remove-FromOMSWorkspace -RunOn HybridWorkerG1 -Parameters $params -Wait

#if using portal use JSON format
#ComputerName = ['dc2','dc4','vmhost5','vmhost6','vmhost7']