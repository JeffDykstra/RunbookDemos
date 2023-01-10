#targets Runbook GetAutoAccounts in Automation1
<#[SuppressMessage("Microsoft.Security", "CS002:SecretInNextLine", Justification="Demo Purposes Only Test")]#>
$webhookURI='https://a6c1c64b-5315-4b64-8b56-bce35851e031.webhook.eus2.azure-automation.net/webhooks?token=LXbsL93N9u4GMuxts95VHmqW3vSJW%2bvkodg%2bwIc8yiA%3d'
$Someobject = Get-CimInstance -ClassName Win32_operatingsystem
$json = $someobject | ConvertTo-Json
$job = Invoke-RestMethod -Uri $webhookURI -Method Post -Body $json
Get-AzAutomationJob -Id $job.jobids[0] -AutomationAccountName Automation1 -ResourceGroupName OpsMgmt1