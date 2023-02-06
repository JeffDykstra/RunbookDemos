param(
    [parameter(Mandatory)]
    [string]$computername,
    [int]$ConfigurationModeFrequencyMins=10080,
    [int]$RefreshFrequencyMins=10080,
    [parameter(Mandatory)]
    [string]$configurationName,
    [string]$AutomationAccount='automate1',
    [string]$AutomationAccountResourceGroup = 'OpsMgmt'
    )

[DSCLocalConfigurationManager()]
Configuration SimpleLCMConfig
{
param(
    [string]$computername,
    [string]$registrationKey,
    [string]$pullserverUrl,
    [int]$ConfigurationModeFrequencyMins,
    [int]$RefreshFrequencyMins,
    [string]$configurationName)

Node $ComputerName
{
Settings{
    ConfigurationMode = 'ApplyAndAutoCorrect'
    RefreshMode = 'Pull'
    RebootNodeIfNeeded = $true
    ConfigurationModeFrequencyMins = $ConfigurationModeFrequencyMins
    RefreshFrequencyMins = $RefreshFrequencyMins
    }
    ConfigurationRepositoryWeb DSCHTTPS {
        ServerURL = $PullServerUrl
        AllowUnsecureConnection = $false
        RegistrationKey = $RegistrationKey
        ConfigurationNames =@("$configurationName")
    }
    ReportServerWeb DSCReporting
    {
        ServerURL = $PullServerUrl
        RegistrationKey = $RegistrationKey
    }
}
}
Write-output "Running on:$Env:Computername"
Connect-AzAccount -Identity
$registrationInfo = Get-AzAutomationRegistrationInfo -ResourceGroupName $AutomationAccountResourceGroup -AutomationAccountName $AutomationAccount
$RegistrationKey = $registrationInfo.PrimaryKey
$pullserverUrl = $registrationInfo.Endpoint

$DSCTempPath ='c:\temp\DSCTEMP'
If (-not (Test-Path $DSCTempPath))
{
mkdir $DSCTempPath -Force
}
SimpleLCMConfig -computername $computername -registrationKey $registrationKey -pullserverUrl $pullserverUrl -ConfigurationModeFrequencyMins $ConfigurationModeFrequencyMins -RefreshFrequencyMins $RefreshFrequencyMins -OutputPath $DSCTempPath -Configurationname $configurationName
$adminCred = get-automationPSCredential -Name KaylosAdmin
Set-DscLocalConfigurationManager -Path $DSCTempPath -ComputerName $computername -Credential $AdminCred -Verbose -Force
Start-Sleep -Seconds 1
Remove-Item -Path $DSCTempPath -Force -Confirm:$false -Recurse