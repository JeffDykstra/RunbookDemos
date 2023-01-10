#.\scripts\AzureAutomation
<#For addition error handling see:
https://github.com/microsoft/AzureAutomation-Account-Modules-Update/blob/master/Update-AutomationAzureModulesForAccount.ps1
#>

$RunAsConnection = Get-AutomationConnection -Name "AzureRunAsConnection"
 Connect-AzAccount `
                -ServicePrincipal `
                -TenantId $RunAsConnection.TenantId `
                -ApplicationId $RunAsConnection.ApplicationId `
                -CertificateThumbprint $RunAsConnection.CertificateThumbprint 


Select-AzSubscription -SubscriptionId $RunAsConnection.SubscriptionID

Get-AzAutomationAccount