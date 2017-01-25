<#BACKUP
This script will show you how to run a full backup on a specified database.
#>
Import-Module SQLPS
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

$databasename = "AdventureWorks2014"
$timestamp = Get-Date -format yyyyMMddHHmmss
$backupfolder = "C:\Lab Files\Student\"
$backupfile = "$($databasename)_Full_$($timestamp).bak"
$fullBackupFile = Join-Path $backupfolder $backupfile

Backup-SqlDatabase `
-ServerInstance $instanceName `
-Database $databasename `
-BackupFile $fullBackupFile `
-Checksum `
-Initialize `
-BackupSetName "$databasename Full Backup" `
-CompressionOption On

<#________________________________________________________________________________________

#RESTORE
In order to demonstrate this we must first detach the AdventureWorks2014 database.

#DETACH DATABASE
The below block of code will detach the AdventureWorks2014 database.

$databaseName = "AdventureWorks2014"
$server.DetachDatabase($databaseName, $false, $false)

#RESTORE

$originalDBName = "AdventureWorks2014"
$restoredDBName = "AdventureWorks2014_Restored"
$backupfilefolder = "C:\Lab Files\Student\"
$fullBackupFile = "C:\Lab Files\Student\AdventureWorks2014_Full_20161117143847.bak"

Restore-SqlDatabase `
-ReplaceDatabase `
-ServerInstance $instanceName `
-Database $restoredDBName `
-BackupFile $fullBackupFile `
-NoRecovery

#
Switch to SQL Server Management Studio, refresh the Databases folder and review
the results.
#>