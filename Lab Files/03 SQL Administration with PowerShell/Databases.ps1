#The first step is to import SQL Server module.
Import-Module SQLPS

#Next, we create a server object to retrieve the information we want.
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

<#Finally, we specify what we want returned. We ask for the list of
databases and then send them through the pipeline and ask that they 
be returned in a list format.#>

$server.Databases | Select Name, Owner