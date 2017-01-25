<#INDEXES
This script will reorganize/rebuild indexes.
#>
#We start by importing the SQLPS module and creating an SMO server object.
Import-Module SQLPS
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

<#Next we specify how we want the system to respond to verbose messages, and identify
the database, table, and schema we intend to work with.
#>
$VerbosePreference = "Continue"
$databasename = "AdventureWorks2014"
$database = $server.Databases[$databasename]
$tableName = "Product"
$schemaName = "Production"
$table = $database.Tables |
         Where-Object Schema -like $schemaName |
         Where-Object Name -like $tableName
<#
Finally, we use IF/ELSE statements to configure the 
reorganize/rebuild process of the specified table indexes.
#>

$table.Indexes |
ForEach-Object {
   $index = $_
   $index.EnumFragmentation() |
   ForEach-Object {
        $item = $_
        #reorganize if 10 and 30% fragmentation
        if($item.AverageFragmentation -ge  10 -and
           $item.AverageFragmentation -le 30  -and
           $item.Pages -ge 1000)
        {
           Write-Verbose "Reorganizing $index.Name ... "
           $index.Reorganize()
        }
        #rebuild if more than 30%
        elseif ($item.AverageFragmentation -gt 30 -and
                $item.Pages -ge 1000)
        {
           Write-Verbose "Rebuilding $index.Name ... "
           $index.Rebuild()
        }
   }
}
$VerbosePreference = "Continue"