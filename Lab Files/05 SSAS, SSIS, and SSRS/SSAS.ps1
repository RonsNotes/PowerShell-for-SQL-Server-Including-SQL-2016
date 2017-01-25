<#SQL SERVER ANALYSIS SERVICES
This script will explore and utilize the SSAS instance.
#>

<#SSAS Cmdlets
The below command will install the SQLASCmdlets module and retrieve 
a list of the cmdlets.
#>
Get-Command -Module SQLASCmdlets

<#Retrieving SSAS Instance Information
The below blocks of code will retrieve information pertaining to 
the SSAS instance.
#>
    Import-Module SQLPS
    Import-Module SQLASCmdlets

    <#
    In this next block, we'll create an AnalysisServices.Server object, 
    then connect to your Analysis Services server.
    #>
    $SSASServer = New-Object Microsoft.AnalysisServices.Server
    $instanceName = "localhost"
    $SSASServer.connect($instanceName)

    <#
    The below lines of code will utilize the object we created in the 
    prior block to retrieve all properties for the SSAS instance.
    #>
    $SSASServer | 
    Select-Object *

<#BACKUP AND RESTORE
In this section we will examine the code to backup and restore your 
SSAS databases.
#>

    <#Backup
    #>
    $instanceName = "localhost" 
    $backupfile = "C:\Lab Files\Student\SSAS_Backup_AWDW.abf"
    Backup-ASDatabase `
    -BackupFile $backupfile `
    -Name "AdventureWorksDW2014Multidimensional-EE" `
    -Server $instanceName `
    -AllowOverwrite `
    -ApplyCompression

    <#Restore
    #>
    $instanceName = "localhost"
    $backupfile = "C:\Lab Files\Student\SSAS_Backup_AWDW.abf"
    Restore-ASDatabase `
    -RestoreFile $backupfile `
    -Server $instanceName `
    -Name "AdventureWorksDW2014Multidimensional-EE" `
    -AllowOverwrite