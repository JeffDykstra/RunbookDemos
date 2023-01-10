#use Managed Identity
Connect-AzAccount -Identity

#Test Authentication example
Get-AzAutomationAccount -ResourceGroupName OpsMgmt1