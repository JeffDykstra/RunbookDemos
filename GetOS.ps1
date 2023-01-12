function Get-OsInformation
{
    param(
    [parameter(Mandatory,
               HelpMessage = "Please enter a computer name",
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true 
                )]
    [Alias("IPAddress","HostName","__Server")]
    [string[]]$computername='localhost')
    Begin{ Write-Verbose "begin OS info gathering"}

    Process
    {
        foreach ($computer in $computername)
        {
        Get-CimInstance -ClassName win32_operatingsystem -ComputerName $computer  | 
         Select-Object PsComputerName,Caption,LastBootUpTime
        }
    }
    end{Write-Verbose "end OS info gathering"}
}
Write-Verbose $env:computername
Get-OsInformation -computername localhost
$psversiontable
dir variable:

