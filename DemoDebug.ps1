param($loopCount=100)
Write-verbose  "Start of debug demo runbook on: $($ENV:computername)"
"Running script on: " + $env:COMPUTERNAME
"Host Process Id: $PID"
if($host.Runspace.Id)
{
    "RunspaceID is:$($host.Runspace.Id)" #this is often not populated
}
$number = 0
Wait-debugger
while ($number -lt $loopcount){
Start-Sleep 1
Write-output $number
$number++
}

write-output "done"
