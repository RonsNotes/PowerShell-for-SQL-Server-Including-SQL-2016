Clear-Host                     #This first line will clear the command line.
Update-Help                    #This cmdlet will update the help system.
Clear-Host
Get-Help Get-Module            #This will return help information on the Get-Module cmdlet.
Get-Module                     #This cmdlet will return the modules currently installed.
Get-Module -ListAvailable      #This will return the modules available for installation.   
Import-Module SQLPS            #This will load the SQLPS module.
Get-Module                     #This cmdlet will return the modules currently installed - Notice you now see SQLPS.
Get-Command -Module *SQL*      #This will return the cmdlets available for use with SQL.