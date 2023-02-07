<#
.SYNOPSIS
  Connects to Azure and stops of all VMs in the specified Azure subscription or resource group

.DESCRIPTION

.PARAMETER ResourceGroupName
   Optional
   Allows you to specify the resource group containing the VMs to stop.  
   If this parameter is included, only VMs in the specified resource group will be stopped, otherwise all VMs in the subscription will be stopped.  
Modified from:
https://github.com/azureautomation/stop-azure-v2-vms-001
#>

param (
	[Parameter(Mandatory = $false)] 
	[String] $ResourceGroupName
)

Connect-AzAccount -Identity
if ($ResourceGroupName) 
{ 
	$VMs = Get-AzVM -ResourceGroupName $ResourceGroupName
}
else 
{ 
	$VMs = Get-AzVM
}

# Stop each of the VMs
foreach ($VM in $VMs)
{
	$StopRtn = $VM | Stop-AzVM -Force -ErrorAction Continue

	if ($StopRtn.Status -ne 'Succeeded')
	{
		# The VM failed to stop, so send notice
		Write-Output ($VM.Name + ' failed to stop')
		Write-Error ($VM.Name + ' failed to stop. Error was:') -ErrorAction Continue
		Write-Error (ConvertTo-Json $StopRtn.Error) -ErrorAction Continue
	}
	else
	{
		# The VM stopped, so send notice
		Write-Output ($VM.Name + ' has been stopped')
	}
}