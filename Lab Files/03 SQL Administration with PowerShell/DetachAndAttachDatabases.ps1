<#DETACH
The below block of code will detach the AdventureWorks2014 database.
#>
Import-Module SQLPS
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

<#The below lines of code will detach the below specified database.
There are three parameters needed to proceed
-DatabaseName
-Flag for UpdateStatistics (Boolean)
-Flag for RemoveFullTextIndexFile (Boolean)
#>
$databaseName = "AdventureWorks2014"
$server.DetachDatabase($databaseName, $false, $false)

<#ATTACH
The below blocks of code will attach the AdventureWorks2014 database.
#>
$databasename = "AdventureWorks2014"
$owner = "RONSNOTES\Student"
$mdfname = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014_Data.mdf"

<#This next block will create a StringCollection object to 
store the additional related data and lab files for the database 
we are going to attach. 
#>
$filecoll = New-Object System.Collections.Specialized.StringCollection

    #Adds all data files (which includes the primary)
    $server.EnumDetachedDatabaseFiles($mdfname) |
    Foreach-Object {
      $filecoll.Add($_)
    }

    #Adds all log files
    $server.EnumDetachedLogFiles($mdfname) |
    ForEach-Object {
        $filecoll.Add($_)
    }

<#
Finally, we utilize the AttachDatabase method of the SMO server object 
to attach the database. As you can see below, the information we configured 
above is passed as parameters providing all the files and values needed to 
successfully attach the database.
#>
$server.AttachDatabase($databasename, $filecoll, $owner, [Microsoft.SqlServer.Management.Smo.AttachOptions]::None)