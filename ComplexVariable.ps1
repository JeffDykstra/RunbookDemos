$EncryptedVariable =get-AzAutomationVariable -ResourceGroupName OpsMgmt1 -AutomationAccountName Automation1 -Name test1
$simpleVariable= get-AzAutomationVariable -ResourceGroupName OpsMgmt1 -AutomationAccountName Automation1 -Name test2
$pscustom = [pscustomobject]@{
                                test = (Get-CimInstance win32_operatingsystem)
                                test2 = 'test'
                                test3 = (Get-ADComputer -Identity jeffg1 | select [a-np-z]*) #objectGUID property causes an error
                                timestamp = (get-date)

                            }


$Autoaccount = Get-AzAutomationAccount -ResourceGroupName OpsMgmt1 -Name automation1
$Autoaccount | New-AzAutomationVariable -Name testC1 -Value $pscustom -Encrypted $false
$Autoaccount | Set-AzAutomationVariable -Name testC1 -Value $pscustom -Encrypted $false

$r = $Autoaccount | Get-AzAutomationVariable -Name testc1
$r.value.test.caption