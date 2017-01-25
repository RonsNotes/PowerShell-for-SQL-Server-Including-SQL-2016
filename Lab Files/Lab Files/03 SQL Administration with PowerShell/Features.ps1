Import-Module SQLPS 
$servername = "localhost"  
$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername  

$server |  
Select-Object IsClustered, ClusterName,  FilestreamLevel, IsFullTextInstalled, LinkedServers, IsHadrEnabled, AvailabilityGroups 