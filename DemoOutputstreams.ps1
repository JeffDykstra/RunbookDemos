#Azure Automation Output stream capture Demo
Write-Host 'write to host' #not captured
Write-Output "default output on Hybrid Worker: $($env:COMPUTERNAME) "
Write-Information 'informational output' #not captured
Write-verbose "verbose output" #Capture can be enabled
Write-Warning 'warning output'
Write-Progress -Activity 'progress bar 1' -Status 'complete' #Capture can be enabled
Write-Debug 'debug output' #not captured
Write-Error 'non terminating error'
'after non-terminating error'
throw 'terminating error'
"we won't get to this output"