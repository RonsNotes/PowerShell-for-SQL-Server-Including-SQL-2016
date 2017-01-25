Import-Module SQLPS

$servername = "localhost"  
$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

#Connection string to connect to SQL Server 
$connectionString = "Server=$dataSource;uid=$username; pwd=$password;Database=$database;Integrated Security=False"  
$connection = New-Object System.Data.SqlClient.SqlConnection 
$connection.ConnectionString = $connectionString 

#Retrieve the database count
$server.databases.Count

#create empty array 
$result = @() 

<#For each of the server databases, return the following information:
- Name - Name
- CreateDate - Creation date
- NumUsers - Number of users
- NumTables - Number of tables
- NumSP - Number of stored procedures
- NumUDF - Number of user defined functions
- RecoveryModel - Assigned recovery model
Then dump resulting data into an auto-sized table.
#>
$server.Databases | 
Where-Object IsSystemObject -eq $false | 
ForEach-Object {
     $db = $_     
     $object = [PSCustomObject] @{        
     Name          = $db.Name        
     CreateDate    = $db.CreateDate      
     NumUsers      = $db.Users.Count 
     NumTables     = $db.Tables.Count       
     NumSP         = $db.StoredProcedures.Count        
     NumUDF        = $db.UserDefinedFunctions.Count
     RecoveryModel = $db.RecoveryModel             }     
     $result += $object }
#Format results into a table
     $result | Format-Table -AutoSize 