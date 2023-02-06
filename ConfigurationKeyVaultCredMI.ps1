#TODO
#Still need to test using managed idenity
Configuration ConfigurationKeyVaultCredMI
{
    param(
        [parameter(Mandatory)]
        [string]$keyVaultUserName,
        [parameter(Mandatory)]
        [string]$KeyvaultPWName,
        [parameter(Mandatory)]
        [string]$keyvaultName,
        [parameter(Mandatory)]
        [string]$keyvaultRGName
    )
    Connect-AzAccount -Identity
    $keyvault = Get-AzKeyVault -ResourceGroupName $keyvaultRGName -VaultName $keyvaultName
    #$username = $keyVault | Get-AzKeyVaultSecret -Name $keyVaultUserName | ConvertFrom-SecureString -AsPlainText
    $usernameSec = $keyVault | Get-AzKeyVaultSecret -Name $keyVaultUserName
    $username = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($usernameSec.SecretValue))
    $password = $keyVault | Get-AzKeyVaultSecret -Name $KeyvaultPWName
    $cred = new-object -TypeName PSCredential -ArgumentList $username,$password.SecretValue

    node ($AllNodes.NodeName)
    {
        file TempDir
        {
            Ensure = 'Present'
            DestinationPath = 'C:\temp3'
            SourcePath = '\\dc4\testshare'
            Type = 'Directory'
            Recurse = $true
            PsDscRunAsCredential = $cred
        }
    }
}