param(
	$input1,
	$input2,
	$date,
	$EmailofSubmitter,
	$SubmissionTime
)
Write-verbose  "Start of runbook on: $($ENV:computername)"
Write-Warning  "Start of runbook on: $($ENV:computername)"
[pscustomobject]$PSBoundParameters | ConvertTo-Json
	<#
	$input1
	$input2
	$date
	$EmailofSubmitter
	$SubmissionTime
	#>