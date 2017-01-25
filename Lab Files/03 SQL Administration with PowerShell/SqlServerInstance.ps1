Import-Module SQLPS

<#To begin we will enable the SQLBrowser service, then start the corresponding 
service.#>

Set-Service SQLBrowser -StartupType Automatic
Start-Service "SQLBrowser"

<#Switch back to SQL Config Manager, refresh and notice the Browser is now running.
We'll now create a ManagedComputer object in order to retrieve SQL Server instances information.#>

$instanceName = "localhost"
$managedComputer = New-Object Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer $instanceName

<#This next line of code below will utilize the object we created above to return the SQL Instances 
installed.#>
    
$managedComputer.ServerInstances