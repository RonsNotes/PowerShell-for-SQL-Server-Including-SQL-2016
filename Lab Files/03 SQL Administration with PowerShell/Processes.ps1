#Import the SQL Server module and create the SMO Server object.
Import-Module SQLPS
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

<#Next, we will use the SMO Server object to list all processes. We specified 
the columns we would like returned, then piped them into an AutoSized table.#>
$server.EnumProcesses() |

Select-Object Name, 
Spid, 
Command, 
Status,
Login, 
Database, 
BlockingSpid | 

Format-Table –AutoSize

<#The below block of code will identify and return only the 
blocking processes.#>
$server.EnumProcesses() |

Where-Object BlockingSpid -NE 0 |

Select-Object Name, 
Spid, 
Command, 
Status,
Login, 
Database, 
BlockingSpid | 

Format-Table –AutoSize

<#To kill a particular process, run the below block of code. 
The below block will identify the process causing the block and
will kill it.#>
$VerbosePreference = "Continue"

$server.EnumProcesses() |

Where-Object BlockingSpid -NE 0 |

ForEach-Object {
   Write-Verbose "Killing BlockingSpid $($_.BlockingSpid)"
   $server.KillProcess($_.BlockingSpid)
}

$VerbosePreference = "SilentlyContinue"