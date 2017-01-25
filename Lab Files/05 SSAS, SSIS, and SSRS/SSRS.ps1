<#SQL SERVER REPORTING SERVICES
#>

<#Retrieving the items in your SSRS Report Server#>
<#First we specify a few variables#>
$reportServerUri  = "http://studentserver01/ReportServer/ReportService2010.asmx"
$proxy = New-WebServiceProxy -Uri $reportServerUri -UseDefaultCredential

#Request all items listed on the report server.
$proxy.ListChildren("/", $true) |
Select-Object Name, TypeName, Path, CreationDate |
Format-Table -AutoSize



<#Retrieving the properties of a single SSRS report#>
<#First we specify a variable#>
$reportPath = "/My Table Report"

#Retrieve the properties of the above specified report.
$proxy.ListChildren("/", $true) |
Where-Object Path -eq $reportPath



<#Creating an SSRS Data Source#>
$type = $Proxy.GetType().Namespace

#create a DataSourceDefinition object and configure corresponding settings
$dataSourceDefinitionType = ($type + '.DataSourceDefinition')
$dataSourceDefinition = New-Object($dataSourceDefinitionType)

$dataSourceDefinition.CredentialRetrieval = "Integrated"
$dataSourceDefinition.ConnectString = "Data Source=StudentServer01;Initial Catalog=AdventureWorks2014"
$dataSourceDefinition.extension = "SQL"
$dataSourceDefinition.enabled = $true
$dataSourceDefinition.Prompt = $null
$dataSourceDefinition.WindowsCredentials = $false

#Create data source
$dataSource = "MyAdventureWorks2014"
$parent = "/"
$overwrite = $true

$newDataSource = $proxy.CreateDataSource(
    $dataSource, $parent, $overwrite,$dataSourceDefinition, $null)