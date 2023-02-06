$configdata = @{
	AllNodes = @(
		@{
			NodeName = '*'
            PSDscAllowPlainTextPassword = $True
            PSDscAllowDomainUser = $True
		},
		@{
			NodeName = 'KeyVaultCredTest'
		}
	)
}

$splatParams=@{
    AutomationAccountName = 'Automation1'
    ConfigurationName = 'ConfigurationKeyVaultCred'
    ResourceGroupName  = 'OpsMgmt1'
    ConfigurationData = $configdata
    Parameters =  @{
                        KeyVaultName='jeffdykVault1'
                        keyVaultUserName = 'testaccount'
                        KeyvaultPWName ='testaccountPW'
                        keyvaultRGName = 'SharedInfrastructure'
                    }
}
Connect-AzAccount -Identity
Start-AzAutomationDscCompilationJob @splatParams