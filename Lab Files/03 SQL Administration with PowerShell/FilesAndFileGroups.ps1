#Import the SQL Server module and create the SMO Server object.
Import-Module SQLPS
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

<#CREATE A FILEGROUP
First we will configure a few variables. We need to specify 
what we want the filgroup to be named,and which database it 
belongs to.
#>
$databasename = "AdventureWorks2014"
$database = $server.Databases[$databasename]
$fgname = "ActiveFileGroup"

#Filegroup creation
$fg = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Filegroup -Argumentlist $database, $fgname
$fg.Create()