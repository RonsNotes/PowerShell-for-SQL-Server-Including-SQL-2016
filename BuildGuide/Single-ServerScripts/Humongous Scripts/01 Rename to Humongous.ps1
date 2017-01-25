﻿# *************************************************************************
#
# Script Name: Rename to Humongous
# PS Version: 5.1
# Author: Ron Davis
# 
# Last Modified: 1/13/2017
# 
# Description: This script  will rename the virtual machine.         
#
#
# *************************************************************************

#Verify PowerShell is running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
	Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Sleep -Seconds 1
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
	exit
}


#TASK: RENAMING THE VIRTUAL MACHINE
Rename-Computer -NewName Humongous -Restart -Force