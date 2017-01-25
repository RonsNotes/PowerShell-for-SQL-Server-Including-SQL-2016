<#JOBS
This script will list all jobs for the specified instance of SQL Server.
#>
Import-Module SQLPS
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

<#The below block of code will the following information for any jobs
found:
- Name of the job
- OwnerLoginName
- LastRunDate
- LastRunOutcome
We then request the information to be dumped into an auto-sized table.
#>
$jobs=$server.JobServer.Jobs
$jobs |
Select-Object Name, OwnerLoginName,
LastRunDate, LastRunOutcome |
Sort-Object -Property Name |
Format-Table -AutoSize