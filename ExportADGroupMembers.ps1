Param([string]$GroupName = 'DemoGroup1')

$groupmembers = Get-ADGroupMember -Identity $GroupName -Recursive
$VariableName = $GroupName+'Members'
Set-AutomationVariable -Name $VariableName -Value ($groupmembers.sid.value -join ';')

