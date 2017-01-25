<#SQL SERVER INTEGRATION SERVICES
#>
Import-Module SQLPS

<#CREATING FOLDERS TO STORE PACKAGES
#>
<#Load the ManagedDTS Assembly#>
Add-Type -Path C:\Windows\Microsoft.NET\assembly\GAC_MSIL\Microsoft.SqlServer.ManagedDTS\v4.0_13.0.0.0__89845dcd8080cc91\Microsoft.SqlServer.ManagedDTS.dll

<#Create an application object#>
$app = New-Object "Microsoft.SqlServer.Dts.Runtime.Application"

<#Folder creation#>

<#Folder creation #1 - Create Folder in Package Store
Specify a few variables: the server we intend to work with and the intended
new folder name.
#>
$server = "localhost"
$newFolder = "BlueBuffaloPress"
    
<#Create a folder in package store#>
if (!$app.FolderExistsOnDtsServer("\File System\$($newFolder)", $server))
    {
     $app.CreateFolderOnDtsServer("\File System\", $newFolder, $server)
    }

<#Folder creation #2 - Create a time-stamped folder in MSDB folder
Specify a few variables: timestamp format, and the intended new 
folder name. We don't have to specify the server again as we are 
working with as we identified that in the last block of code.
#>
$ts = Get-Date -format "yyyy-MMM-dd-hhmmtt"
$newFolder = "My SSIS Package $($ts)"

<#Create a folder in MSDB folder#>
if (!$app.FolderExistsOnSqlServer($newFolder, $server, $null, $null))
    {
     $app.CreateFolderOnSqlServer("\", $newFolder, $server, $null, $null)
    }

<#DEPLOYING A PACKAGE TO THE PACKAGE STORE
#>

<#Specify a few variables
In this next block we will specify the package to be deployed and where
we intend to deploy to.
#>
$server = "localhost"
#Package information
$dtsx = "C:\Lab Files\05 SSAS, SSIS, and SSRS\MyPerfCountersCollect.dtsx"
$package = $app.LoadPackage($dtsx, $null)
#Intended deployment location
$SSISPackageStorePath = "\File System\BlueBuffaloPress"
$destinationName = "$($SSISPackageStorePath)\$($package.Name)"

<#Finally, we utilize the app we created to save the specified package
to the package store.#>
$app.SaveToDtsServer($package, $events, $destinationName, $server)

<#Creating an SSISDB Catalog
#>

<#Load the IntegrationServices Assembly#>
Add-Type -Path C:\Windows\assembly\GAC_MSIL\Microsoft.SqlServer.Management.IntegrationServices\13.0.0.0__89845dcd8080cc91\Microsoft.SqlServer.Management.IntegrationServices.dll 

#First, we create a SQLConnection object.
$instanceName = "localhost"
$connectionString = "Data Source=$instanceName;Initial Catalog=master;Integrated Security=SSPI;"                        
$conn = New-Object System.Data.SqlClient.SqlConnection $connectionString            

#Next we'll create an IntegrationServices object.
$SSISServer = New-Object Microsoft.SqlServer.Management.IntegrationServices.IntegrationServices $conn    

<#To create an SSISDB catalog, we create a new Catalog object, which accepts three parameters: 
-the IntegrationServices server object
-name of the new catalog (SSISDB)
-a password
#>
if(!$SSISServer.Catalogs["SSISDB"])
    {
    $SSISDB = New-Object Microsoft.SqlServer.Management.IntegrationServices.Catalog ($SSISServer, "SSISDB", "Passw0rd")           
    $SSISDB.Create()  
    }